


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
    zs = Corr
    
    #The Heatmap
    CairoMakie.heatmap!(ax, xs, ys, zs,              #Yticks
    colormap = Reverse(:deep))

                                                             
    Colorbar(fig[1,2],                        #Colorbar
                 ticks = 0.0:0.1:1.0)            #Colorbar ticks
    
    fig
    
    
    end
    
    


function CircPlot(EigA)


##############################################
#Plot of Arnoldi Eigenvalues 
############################################## 


thet=range( 0, 2*pi, length = 500);
xcirc=cos.(thet)
ycirc=sin.(thet)


scene,ax,ts=CairoMakie.lines(xcirc, ycirc,
     axis=( ; xlabel = L"Re{λ}",                                     #Label for X  
             ylabel = L"Im{λ}",             #Label for Y
            # title = "Scatter Plot of Polfed Eigenvalues L=8",
             aspect = 1)
             , color = :black, linewidth = 1, linestyle = :dash,
             )
                                                              
xs = real.(EigA);              #Axis Range X (log scale)
zs = imag.(EigA);              #Axis Range X (log scale)

CairoMakie.scatter!(xs, zs, color = colorant"#00539a", markersize = 17, strokecolor = :black, strokewidth=0.1)

###### for every point in the plot add a dashed line connecting it to the origin

for i in 1:length(EigA)
    CairoMakie.lines!([0.0, xs[i]], [0.0, zs[i]], color = :black, linewidth = 0.2, linestyle = :dash)
end

scene

end