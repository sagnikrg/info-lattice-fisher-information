using CairoMakie
using GeometryBasics#: Point2f
#using Colors



function draw_info_lattice(infolattice)
    
    fig = Figure(size = (800, 600), fontsize = 20)
    ax = Axis(fig[1, 1], aspect = DataAspect(), 
            xticks = (1.5:0.5:(length(infolattice[1])+0.5), string.(1:0.5:(length(infolattice[1])))), 
            yticks = ((1:(length(infolattice[1]))).*(sqrt(3)/2), string.(1:(length(infolattice[1]))))
            )

    a = Point2f(1, 0)
    b = Point2f(0.5, sqrt(3)/2)

    xlims!(ax, 0, length(infolattice[1])+2)
    ylims!(ax, 0, length(infolattice))

    radius = 0.55  # Size of the hexagons
    hex_vertices = [Point2f(radius * cos(θ), radius * sin(θ)) for θ in π/6:π/3:2π]

    for (nb, line) in enumerate(infolattice)
        for (na, val) in enumerate(line)
            coord = na * a + nb * b
            poly = Polygon([v + coord for v in hex_vertices])
            p=val
            # Add rounded effect using stroke
            poly!(ax, poly,  color = (viridis[36]*(p)+magma[1]*(1-p)),strokewidth = 1.5, strokecolor = :black)
        end
            # color = val, colormap = :viridis, colorrange = (0, 1),
                  
    end
    
    Colorbar(fig[1,2] ,                       #Colorbar
                 ticks = 0.0:0.1:1.0)            #Colorbar ticks
    
    fig
    
    return fig
end



function draw_info_lattice(infolattice, cmap)
    
    fig = Figure(size = (800, 600), fontsize = 20)
    ax = Axis(fig[1, 1], aspect = DataAspect(), 
            xticks = (1.5:0.5:(length(infolattice[1])+0.5), string.(1:0.5:(length(infolattice[1])))), 
            yticks = ((1:(length(infolattice[1]))).*(sqrt(3)/2), string.(1:(length(infolattice[1]))))
            )

    a = Point2f(1, 0)
    b = Point2f(0.5, sqrt(3)/2)

    xlims!(ax, 0, length(infolattice[1])+2)
    ylims!(ax, 0, length(infolattice))

    radius = 0.55  # Size of the hexagons
    hex_vertices = [Point2f(radius * cos(θ), radius * sin(θ)) for θ in π/6:π/3:2π]

    for (nb, line) in enumerate(infolattice)
        for (na, val) in enumerate(line)
            coord = na * a + nb * b
            poly = Polygon([v + coord for v in hex_vertices])
            p=val
            # Add rounded effect using stroke
            poly!(ax, poly,  color = val, colormap = cmap, colorrange = (1, 0), strokewidth = 1.5, strokecolor = :black)
        end
          
                  
    end
    
    return fig
end

;
;