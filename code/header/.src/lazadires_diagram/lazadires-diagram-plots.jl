


function LazadiresDiagramPlot(Corr)

###############################
#Phase ordered <n|Z|m>  
###############################


xs = range(-pi, pi, length = 257)              #Axis Range X
ys = range(-pi, pi, length = 257)              #Axis Range Y    
zs = Corr                                    #The Heatmap
fig,ax,hm=CairoMakie.heatmap(xs, ys, zs,
     axis=(; xlabel = L"$T\omega$",          #Label for X  
             ylabel = L"$T\omega'$",         #Label for Y
             title = L"Eigenstructre: $<\omega'|\sigma^Z|\omega>$ for L=8",      #Plot Title
             xticks = (-3:3),                #Xticks
             yticks = (-3:3) ),              #Yticks
             colormap = Reverse(:deep))      #Colormap
                                                         
Colorbar(fig[1,2],hm,                        #Colorbar
             ticks = 0.0:0.1:1.0)            #Colorbar ticks

fig


end


