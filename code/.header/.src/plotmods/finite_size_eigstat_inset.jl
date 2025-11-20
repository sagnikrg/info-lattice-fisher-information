using CairoMakie
using ColorSchemes

#------------------------------------------------------------------------------
# First we define the plots as insets
# Then we will use the multiple dispatch to create a function with default axis
# The other options should be automatically followed through;
#------------------------------------------------------------------------------


#----------------------------------------------------------------
#  Inset:
#----------------------------------------------------------------

#  Without Error Bands:


function finite_size_eigstat(ax, LList, WList, finitesizescaling, cmap)
    ############################################
    # finite size scaling
    ############################################

    #cmap=cgrad(cmap, rev=true)


    xlims!(ax, (WList[1], WList[end]))

    # define a consistent color palette
    pal = cgrad(cmap, 6 * length(LList), categorical = true)

    for (i, L) in enumerate(LList)
        col = pal[6 * i - 3 ]


        # mean line on top
        lines!(ax, WList, finitesizescaling[i, :];
               color = col, linewidth = 2, label = "L=$(L)")
    end

    axislegend(ax)
    return fig
end



# With Error Bands:


function finite_size_eigstat(ax, LList, WList, finitesizescaling, lower, upper, cmap)
    ############################################
    # finite size scaling
    ############################################

    #cmap=cgrad(cmap, rev=true)

    xlims!(ax, (WList[1], WList[end]))
    
    # define a consistent color palette
    pal = cgrad(cmap, 6 * length(LList), categorical = true)

    for (i, L) in enumerate(LList)
        col = pal[ 6 * i - 3 ]

        # confidence band first (semi-transparent)
        draw_error_band(ax, WList, lower[i, :], upper[i, :], col)

        # mean line on top
        lines!(ax, WList, finitesizescaling[i, :];
               color = col, linewidth = 2, label = "L=$(L)")
    end

    axislegend(ax)
    return fig
end



#-------------------------------------------------------
# Default ColorSchemes
#-------------------------------------------------------

# Insets

        function finite_size_eigstat(ax, LList, WList, finitesizescaling)
            finite_size_eigstat(ax, LList, WList, finitesizescaling, :viridis)
        end

        function finite_size_eigstat(ax, LList, WList, finitesizescaling, lower, upper)
            finite_size_eigstat(ax, LList, WList, finitesizescaling, lower, upper, :viridis)
        end





#-------------------------------------------------------
# Specific Cases
#-------------------------------------------------------


        
function finite_size_eigstat_lsr(ax, LList, WList, finitesizescaling, lower, upper, cmap)
    ############################################
    # finite size scaling
    ############################################

    #cmap=cgrad(cmap, rev=true)

    xlims!(ax, (WList[1], WList[end]))
    ylims!(ax, (0.35, 0.65))
 
    # define a consistent color palette
    pal = cgrad(cmap, 6 * length(LList), categorical = true)

    for (i, L) in enumerate(LList)
        col = pal[ 6 * i - 3 ]

        # confidence band first (semi-transparent)
        draw_error_band(ax, WList, lower[i, :], upper[i, :], col)

        # mean line on top
        lines!(ax, WList, finitesizescaling[i, :];
               color = col, linewidth = 2, label = "L=$(L)")
    end

    axislegend(ax)
    return fig
end
