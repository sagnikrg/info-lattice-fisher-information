using CairoMakie
using ColorSchemes

#------------------------------------------------------------------------------
# First we define the plots as insets
# Then we will use the multiple dispatch to create a function with default axis
# The other options should be automatically followed through;
#------------------------------------------------------------------------------

include("finite_size_eigstat_dependencies.jl")

include("finite_size_eigstat_inset.jl")


#----------------------------------------------------------------
#  Wrapper with a Default Axis:
#----------------------------------------------------------------

# Without Error Bands:

function finite_size_eigstat(LList, WList, finitesizescaling, cmap)
    ############################################
    # finite size scaling
    ############################################

    aspect_ratio = 4/3
    fig_width = 800
    fig_height = fig_width / aspect_ratio

    fig = Figure(resolution = (fig_width, fig_height))
    ax = Axis(fig[1, 1])

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



function finite_size_eigstat(LList, WList, finitesizescaling, lower, upper, cmap)
    ############################################
    # finite size scaling
    ############################################

    aspect_ratio = 4/3
    fig_width = 800
    fig_height = fig_width / aspect_ratio

    fig = Figure(resolution = (fig_width, fig_height))
    ax = Axis(fig[1, 1])

    xlims!(ax, (WList[1], WList[end]))

    # define a consistent color palette
       pal = cgrad(cmap, 6 * length(LList), categorical = true)

        for (i, L) in enumerate(LList)
        col = pal[6 * i - 3 ]

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


# Plots
        function finite_size_eigstat(LList, WList, finitesizescaling)
            finite_size_eigstat(LList, WList, finitesizescaling, :viridis)
        end

        function finite_size_eigstat(LList, WList, finitesizescaling, lower, upper)
            finite_size_eigstat(LList, WList, finitesizescaling, lower, upper, :viridis)
        end