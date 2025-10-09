using CairoMakie
using GeometryBasics#: Point2f
#using Colors



function draw_info_lattice(infolattice)
    
    L=length(infolattice[1])

    info_lattice_sum=fill(0.0,L)
    for i in 1:L
        info_lattice_sum[i]=sum(infolattice[i])
    end

    cmap=Reverse(:navia)


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
           # poly!(ax, poly,  color = (viridis[36]*(p)+magma[1]*(1-p)),strokewidth = 1.5, strokecolor = :black)
           poly!(ax, poly,  color = val, colormap = cmap, colorrange = (1, 0), strokewidth = 1.5, strokecolor = :black)
        end
           
                  
    end

    ax_inset = Axis(fig[1, 1],
    width=Relative(0.2),
    height=Relative(0.2),
    halign=0.1,
    valign=0.9,
    title="Info per level")


    #xlims!(ax_inset, 50, 70)
    #ylims!(ax_inset, min_price, max_price)
    line_inset = lines!(ax_inset, 1:L , info_lattice_sum, color=viridis[24], linewidth=2)
    
    Colorbar(fig[1,2] , colormap=cmap,                      #Colorbar
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
    
    Colorbar(fig[1,2] , colormap=cmap,                      #Colorbar
                 ticks = 0.0:0.1:1.0)            #Colorbar ticks
    
    fig

    return fig
end






function draw_info_lattice_comparison(cmap)
    

    L=8
    theta=0.0


    #PM-MBL

    epsilon=0.999999999
    U=brickwall(L,theta, epsilon)
    eigvals,eigvecs=eigen(U);

    Psi=eigvecs[1,:]
    infolattice=info_lattice(Psi, L)

    for i in 2:length(eigvals)
        Psi=eigvecs[i,:]
        infolattice+=info_lattice(Psi,L)
    end

    infolattice=infolattice./length(eigvals)




    fig = Figure(size = (3200, 600), fontsize = 20)
    ax = Axis(fig[1, 1], aspect = DataAspect(), title="PM-MBL",
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
    

   #DTC-MBL

    epsilon=0.0
    U=brickwall(L,theta, epsilon)
    eigvals,eigvecs=eigen(U);

    Psi=eigvecs[1,:]
    infolattice=info_lattice(Psi, L)

    for i in 2:length(eigvals)
        Psi=eigvecs[i,:]
        infolattice+=info_lattice(Psi,L)
    end

    infolattice=infolattice./length(eigvals)


    ax2 = Axis(fig[1, 2], aspect = DataAspect(), title="DTC-MBL",
            xticks = (1.5:0.5:(length(infolattice[1])+0.5), string.(1:0.5:(length(infolattice[1])))), 
            yticks = ((1:(length(infolattice[1]))).*(sqrt(3)/2), string.(1:(length(infolattice[1]))))
            )

    a = Point2f(1, 0)
    b = Point2f(0.5, sqrt(3)/2)

    xlims!(ax2, 0, length(infolattice[1])+2)
    ylims!(ax2, 0, length(infolattice))

    radius = 0.55  # Size of the hexagons
    hex_vertices = [Point2f(radius * cos(θ), radius * sin(θ)) for θ in π/6:π/3:2π]

    for (nb, line) in enumerate(infolattice)
        for (na, val) in enumerate(line)
            coord = na * a + nb * b
            poly = Polygon([v + coord for v in hex_vertices])
            p=val
            # Add rounded effect using stroke
            poly!(ax2, poly,  color = val, colormap = cmap, colorrange = (1, 0), strokewidth = 1.5, strokecolor = :black)
        end
          
                  
    end
    

   #THERMAL

    epsilon=0.5
    U=brickwall(L,theta, epsilon)
    eigvals,eigvecs=eigen(U);

    Psi=eigvecs[1,:]
    infolattice=info_lattice(Psi, L)

    for i in 2:length(eigvals)
        Psi=eigvecs[i,:]
        infolattice+=info_lattice(Psi,L)
    end

    infolattice=infolattice./length(eigvals)


    ax3 = Axis(fig[1, 3], aspect = DataAspect(), title="Thermal", 
            xticks = (1.5:0.5:(length(infolattice[1])+0.5), string.(1:0.5:(length(infolattice[1])))), 
            yticks = ((1:(length(infolattice[1]))).*(sqrt(3)/2), string.(1:(length(infolattice[1]))))
            )

    a = Point2f(1, 0)
    b = Point2f(0.5, sqrt(3)/2)

    xlims!(ax3, 0, length(infolattice[1])+2)
    ylims!(ax3, 0, length(infolattice))

    radius = 0.55  # Size of the hexagons
    hex_vertices = [Point2f(radius * cos(θ), radius * sin(θ)) for θ in π/6:π/3:2π]

    for (nb, line) in enumerate(infolattice)
        for (na, val) in enumerate(line)
            coord = na * a + nb * b
            poly = Polygon([v + coord for v in hex_vertices])
            p=val
            # Add rounded effect using stroke
            poly!(ax3, poly,  color = val, colormap = cmap, colorrange = (1, 0), strokewidth = 1.5, strokecolor = :black)
        end
          
                  
    end
    
   #Critical-MBL

    epsilon=0.85
    U=brickwall(L,theta, epsilon)
    eigvals,eigvecs=eigen(U);

    Psi=eigvecs[1,:]
    infolattice=info_lattice(Psi, L)

    for i in 2:length(eigvals)
        Psi=eigvecs[i,:]
        infolattice+=info_lattice(Psi,L)
    end

    infolattice=infolattice./length(eigvals)


    ax4 = Axis(fig[1, 4], aspect = DataAspect(), title="Critical",
            xticks = (1.5:0.5:(length(infolattice[1])+0.5), string.(1:0.5:(length(infolattice[1])))), 
            yticks = ((1:(length(infolattice[1]))).*(sqrt(3)/2), string.(1:(length(infolattice[1]))))
            )

    a = Point2f(1, 0)
    b = Point2f(0.5, sqrt(3)/2)

    xlims!(ax4, 0, length(infolattice[1])+2)
    ylims!(ax4, 0, length(infolattice))

    radius = 0.55  # Size of the hexagons
    hex_vertices = [Point2f(radius * cos(θ), radius * sin(θ)) for θ in π/6:π/3:2π]

    for (nb, line) in enumerate(infolattice)
        for (na, val) in enumerate(line)
            coord = na * a + nb * b
            poly = Polygon([v + coord for v in hex_vertices])
            p=val
            # Add rounded effect using stroke
            poly!(ax4, poly,  color = val, colormap = cmap, colorrange = (1, 0), strokewidth = 1.5, strokecolor = :black)
        end
          
                  
    end
    

    Colorbar(fig[1,5] , colormap=cmap,                      #Colorbar
                 ticks = 0.0:0.1:1.0)            #Colorbar ticks
    
    fig

    return fig
end

;
;