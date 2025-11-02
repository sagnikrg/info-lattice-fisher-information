




function LazadiresDiagramPlot(Corr)

    ###############################
    #Phase ordered <n|Z|m>  
    ###############################
    
# Desired aspect ratio
aspect_ratio = 6/5

# Set the figure width (for example, 800 pixels)
fig_width = 800
fig_height = fig_width / aspect_ratio
fig = Figure(resolution = (fig_width, fig_height), fontsize=16, title = L"Eigenstructre: $<\omega'|\sigma^Z|\omega>$ for L=8")


ax=Axis(fig[1,1],xlabel = L"$T\omega$",          #Label for X  
ylabel = L"$T\omega'$",         #Label for Y
title = L"Eigenstructre: $<\omega'|\sigma^Z|\omega>$ for L=8",      #Plot Title
xticks = (-3:3),                #Xticks
yticks = (-3:3) )



    xs = range(-pi, pi, length = 257)              #Axis Range X
    ys = range(-pi, pi, length = 257)              #Axis Range Y    
    zs = abs.(Corr)
    
    #The Heatmap
    CairoMakie.heatmap!(ax, xs, ys, zs,              #Yticks
    colormap = Reverse(:deep))

                                                             
    Colorbar(fig[1,2],                        #Colorbar
                 ticks = 0.0:0.1:1.0)            #Colorbar ticks
    
    fig
    
    
    end

    ;