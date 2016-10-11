module Depcheck
  class GraphOutput

    def post(objs, include)

      # installs graphviz if needed
      system 'brew install graphviz' unless graphviz_installed?

      # Check that this is in the user's PATH after installing
      unless graphviz_installed?
        fail "graphviz is not in the user's PATH, or it failed to install"
      end

      # generate graph description
      graph = generate_graph_description(objs, include)

      # create temporary graph dot file
      file_name = 'graph'
      File.open("#{file_name}.dot", 'w') do |f|
        f.write(graph)
      end

      # run dot command
      `dot -T png #{file_name}.dot > #{file_name}.png && open #{file_name}.png`

      # remove temporary file
      File.delete("#{file_name}.dot")
    end

    def generate_graph_description(objs, include)
      nodes = []
      objs.each do |obj|
        obj.dependencies.each do |dep|
          if obj.name.match(/#{include}/) || dep.match(/#{include}/)
            nodes << { source: obj.name, dep: dep }
          end
        end
      end

      desc = "digraph dependencies {\n node [fontname=monospace, fontsize=9, shape=box, style=rounded]\n"
      nodes.each do |node|
        desc += " \"#{node[:source]}\" -> \"#{node[:dep]}\"\n"
      end
      desc += "}\n"

      desc
    end
    private :generate_graph_description

    def graphviz_installed?
      `which dot`.strip.empty? == false
    end
    private :graphviz_installed?

  end
end
