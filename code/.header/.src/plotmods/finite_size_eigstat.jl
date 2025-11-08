using CairoMakie
using ColorSchemes


# without confidence bands


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
    pal = cgrad(cmap, 2 * length(LList), categorical = true)

    for (i, L) in enumerate(LList)
        col = pal[2 * length(LList) - 2 * i + 1]


        # mean line on top
        lines!(ax, WList, finitesizescaling[i, :];
               color = col, linewidth = 2, label = "L=$(L)")
    end

    axislegend(ax)
    return fig
end



# with confidence bands


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
    pal = cgrad(cmap, 2 * length(LList), categorical = true)

    for (i, L) in enumerate(LList)
        col = pal[2 * length(LList) - 2 * i + 1]

        # confidence band first (semi-transparent)
        band!(ax, WList, lower[i, :], upper[i, :];
              color = (col, 0.25))#, strokewidth = 0)

        # mean line on top
        lines!(ax, WList, finitesizescaling[i, :];
               color = col, linewidth = 2, label = "L=$(L)")
    end

    axislegend(ax)
    return fig
end



# Default ColorSchemes



function finite_size_eigstat(LList, WList, finitesizescaling)
    finite_size_eigstat(LList, WList, finitesizescaling, :viridis)
end

function finite_size_eigstat(LList, WList, finitesizescaling, lower, upper)
    finite_size_eigstat(LList, WList, finitesizescaling, lower, upper, :viridis)
end