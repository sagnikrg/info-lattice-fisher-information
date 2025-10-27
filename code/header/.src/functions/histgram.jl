using LinearAlgebra
using CairoMakie



################################
#function for Histogram
################################


# generates a histogram with #split of columns between the (min,max) range
# 
# returns range and columns

function histgram(data, split)                                                                                
    n = length(data)
    n_start=data[1]
    n_end=data[end]


    intervals=LinRange(n_start,n_end,split+1)
 
    ranges = intervals[1:end-1] .=> intervals[2:end]                                                               
    bins = [similar(data, 0) for _ in 1:length(ranges)]  
    Nbins=fill(1,length(ranges) )                                                                         
    for x in data                                                                                                  
        for (i, (a, b)) in pairs(ranges)                                                                                       
            if a <= x < b                                                                                          
                push!(bins[i], x)                                                                                  
                break                                                                                              
            end                                                                                                    
        end                                                                                                        
    end
    for i in 1:length(ranges)
        Nbins[i]=length(bins[i]);
    end

    Nbins=Nbins#/length(data)
    LRange=collect(intervals[1:end-1])
    return LRange, Nbins                                                                                                    
end                                          
                                                                    
; 


# generates a histogram in the specified range
# 

function histgram_interval(data, intervals)                                                                                
    ranges = intervals[1:end-1] .=> intervals[2:end]                                                               
    bins = [similar(data, 0) for _ in 1:length(ranges)]  
    Nbins=fill(1,length(ranges) )                                                                         
    for x in data                                                                                                  
        for (i, (a, b)) in pairs(ranges)                                                                                       
            if a <= x < b                                                                                          
                push!(bins[i], x)                                                                                  
                break                                                                                              
            end                                                                                                    
        end                                                                                                        
    end
    for i in 1:length(ranges)
        Nbins[i]=length(bins[i]);
    end

    return Nbins                                                                                                    
end       



# simple plot function with stair plots using CairoMakie 

function draw_histogram(data, split)
    data=sort(data)
    a = histgram(data, split)
    stairs((a[1][1:end-1].+a[1][2:end])./2, a[2][1:end-1])
end
