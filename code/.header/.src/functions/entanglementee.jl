
function EntanglementEntropy(eigvec, l)

    lhalf=Int(l/2)
    
    eigreshape=reshape(eigvec,2^lhalf,2^lhalf)
    
    U,S,V=svd(eigreshape)
    
    ee=0.0
    
    for i in 1:2^lhalf
        if S[i]>1e-10
        ee=ee+-S[i]^2*log(S[i]^2)
        end
    end
    
    return ee
    
end
    
