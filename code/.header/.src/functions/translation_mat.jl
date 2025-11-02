
#############################################################################################
#Computing the Right Translation Matrtix
#It is based on the observation that the bases are left shifted 
#in their binary form when they are multiplied with the corresponding level dimension.
#############################################################################################

function Tr(level,n)
    #n = 3;              ## number of q-dits
    #level = 2;          ## local dimension 
    dim = level^n;      ## Dimension of Hilbert Space



    A=fill(0+im*0, dim,dim);

    for i in 1:dim-1
        j=1+mod((i-1)*level,(dim-1)) ;
        A[i,j]=1;
    end

    A[dim,dim]=1;

    A
end
;






