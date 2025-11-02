

function offdiag(Corr)
    L=size(Corr)[1];
    Lh=convert(Int64,L/2)
    
    A=[]
    for i in 1:Lh
        A=push!(A, Corr[i,i+Lh])
        A=push!(A, Corr[i+Lh,i])
    end

    A
end




function pi_diag(Corr)
    L=size(Corr)[1];
    Lh=convert(Int64,L/2)
    
    A=[]
    for i in 1:Lh
        A=push!(A, Corr[i,i+Lh])
        A=push!(A, Corr[i+Lh,i])
    end

    A
end



function offdiag(Corr, k)
    L=size(Corr)[1];
    
    A=[]
    for i in 1:L-k
        A=push!(A, Corr[i,i+k])
        A=push!(A, Corr[i+k,i])
    end

    A
end


function pi_offdiag(Corr,k)
    L=size(Corr)[1];
    Lh=convert(Int64,L/2)
    
    A=[]
    for i in 1:Lh+k
        A=push!(A, Corr[i,i+Lh-k])
        A=push!(A, Corr[i+Lh-k,i])
    end

    for i in 1:Lh-k
    A=push!(A, Corr[i,i+Lh+k])
    A=push!(A, Corr[i+Lh+k,i])
    end

    A
end

