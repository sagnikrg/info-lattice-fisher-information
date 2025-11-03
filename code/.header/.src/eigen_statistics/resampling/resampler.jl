### Generating Resapmpler subsets of iterations 
### using random permutations ##

using Random


function resampled_itrlist (Itrnumb::Int, batch_size_resample::Int)
    return randperm(Itrnumb)[1:batch_size_resample]
end