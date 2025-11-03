function finitesize_eigstat(LList, WList, finitesizescaling)

    
############################################
# finite size scaling
############################################


# Desired aspect ratio
aspect_ratio = 4/3

# Set the figure width (for example, 800 pixels)
fig_width = 800
fig_height = fig_width / aspect_ratio



# Create a new figure with specific dimensions
fig = Figure(resolution = (fig_width, fig_height))

# Create an axis in the figure
ax = Axis(fig[1, 1])
        #, xlabel = L"W"
        #, ylabel = L"|Γ_2 -Γ_1|"
        #, title="Scaling of the Mid Spectral Band Gap for various sizes, Avg over 1000 Reln.")



#OPTIONAL XLims

xlims!(ax, (0, 3))
#xlims!(ax, (-2, 0.5))
ylims!(ax, (0.2, 0.5))

# Plot the data


for (i,L) in enumerate(LList[1:end])
         lines!(ax, WList[:], spectral_gap_finitesizescaling[i,:], label = "L=$L", color=viridis[2*length(LList)-2*i+1], linewidth=2)
 #        lines!(ax, log.(WList[:])/log(10), finitesizescaling[i,:], label = "L=$L", color=viridis[2*length(LList)-2*i+1], linewidth=2)
end


# Add a legend
axislegend(ax)

return fig

end