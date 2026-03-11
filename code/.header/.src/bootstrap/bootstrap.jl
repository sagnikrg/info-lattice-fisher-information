# Simple function to perform bootstrap resampling

function bootstrap(data::Vector{T}, n_resamples::Int) where T
    n = length(data)
    resamples = Vector{Vector{T}}(undef, n_resamples)
    
    for i in 1:n_resamples
        resample = [data[rand(1:n)] for _ in 1:n]
        resamples[i] = resample
    end
    
    return resamples
end

# compute statistic for each bootstrap resample

function bootstrap_stats(data::Vector{T}, n_resamples::Int, stat_func::Function) where T
    resamples = bootstrap(data, n_resamples)
    stats = [stat_func(resample) for resample in resamples]
    return stats
end

# compute bootstrap confidence intervals

function bootstrap_ci(data::Vector{T}, n_resamples::Int, stat_func::Function, alpha::Float64) where T
    stats = bootstrap_stats(data, n_resamples, stat_func)
    lower_bound = quantile(stats, alpha / 2)
    upper_bound = quantile(stats, 1 - alpha / 2)
    return (lower_bound, upper_bound)
end