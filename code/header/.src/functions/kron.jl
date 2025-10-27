#######################################
# Computing Kronecker Products
#######################################

# Needs LinearAlgebra


# For Powers of Kronecker Product:

function kron_power(X, n)
    result = X
    for i in 2:n
        result = kron(result, X)
    end
    return result
end



# For Listed Kronecker Product:

function kron_list(AList, ind)


    A=AList[ind[1]];
    for i in 2:length(ind)
    A=kron(A,AList[ind[i]]);
    end
    A 
end

;