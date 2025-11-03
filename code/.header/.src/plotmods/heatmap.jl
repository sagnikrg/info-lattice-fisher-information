

function heatmap_plt(Square)

###############################
# Square for Heatmaps  
###############################
    
# Desired aspect ratio
aspect_ratio = 1.1

# Set the figure width (for example, 1000 pixels)
fig_width = 1000
fig_height = fig_width / aspect_ratio
fig = Figure(resolution = (fig_width, fig_height), fontsize=16)#, title = L"Eigenstructre: $<\omega'|\sigma^Z|\omega>$ for L=8")


ax=Axis(fig[1,1] ,xlabel = L"$|n>$",          #Label for X  
ylabel = L"$<m|$",         #Label for Y
#title = L"Eigenstructre: $<\omega'|\sigma^Z|\omega>$ for L=8",      #Plot Title
xticks = (1:L),                #Xticks
yticks = (1:L) )



    xs = range(1, L, length = L)              #Axis Range X
    ys = range(1, L, length = L)              #Axis Range Y    
    zs = Square
    
    #The Heatmap
    CairoMakie.heatmap!(ax, xs, ys, zs,              #Yticks
    colormap = Reverse(:deep))

                                                             
    Colorbar(fig[1,2], colormap=Reverse(:deep),                       #Colorbar
                 ticks = 0.0:0.1:1.0)            #Colorbar ticks
    
    fig
    
end


function heatmap_plt(Square, cmap)

###############################
# Square for Heatmaps (with custom colormap)
###############################
    
# Desired aspect ratio
aspect_ratio = 1.1

# Set the figure width (for example, 1000 pixels)
fig_width = 1000
fig_height = fig_width / aspect_ratio
fig = Figure(resolution = (fig_width, fig_height), fontsize=16)#, title = L"Eigenstructre: $<\omega'|\sigma^Z|\omega>$ for L=8")


ax=Axis(fig[1,1] ,xlabel = L"$|n>$",          #Label for X  
ylabel = L"$<m|$",         #Label for Y
#title = L"Eigenstructre: $<\omega'|\sigma^Z|\omega>$ for L=8",      #Plot Title
xticks = (1:L),                #Xticks
yticks = (1:L) )



    xs = range(1, L, length = L)              #Axis Range X
    ys = range(1, L, length = L)              #Axis Range Y    
    zs = Square
    
    #The Heatmap
    CairoMakie.heatmap!(ax, xs, ys, zs,              #Yticks
    colormap = cmap)

                                                             
    Colorbar(fig[1,2], colormap=cmap,                       #Colorbar
                 ticks = 0.0:0.1:1.0)            #Colorbar ticks
    
    fig
    
end


function heatmap_plt(Square, type ,cmap)

###############################
# Square for Heatmaps (with custom colormap)
###############################
    
# Desired aspect ratio
aspect_ratio = 1.1

# Set the figure width (for example, 1000 pixels)
fig_width = 1000
fig_height = fig_width / aspect_ratio
fig = Figure(resolution = (fig_width, fig_height), fontsize=22)


ax=Axis(fig[1,1] ,xlabel = L"$|n>$",          #Label for X  
ylabel = L"$<m|$",         #Label for Y
title = "Heatmap of "*string(type)*" for L=$(L)",
#title = L"Eigenstructre: $<\omega'|\sigma^Z|\omega>$ for L=8",      #Plot Title
xticks = (1:L),                #Xticks
yticks = (1:L) )



    xs = range(1, L, length = L)              #Axis Range X
    ys = range(1, L, length = L)              #Axis Range Y    
    zs = Square
    
    #The Heatmap
    CairoMakie.heatmap!(ax, xs, ys, zs,              #Yticks
    colormap = cmap)

                                                             
    Colorbar(fig[1,2], colormap=cmap,                       #Colorbar
                 ticks = 0.0:0.1:1.0)            #Colorbar ticks
    
    fig
    
end