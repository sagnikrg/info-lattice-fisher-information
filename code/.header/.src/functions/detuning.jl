# Old functions with the attempted detuning project

################################
# Detuning of eigenvector overlap
################################



function Detuning(U_Dressed)

    EigvecNew=phase_ordered_eigvecs(U_Dressed);
    
    
    localdim=length(eigvals(Z));
    dim=10

    ########################################################
    # Constructing the correlation matrix:
    ########################################################

    Corr=fill(0.0, size(EigvecNew[2]));
    Corr_detu=fill(0.0, size(EigvecNew[1]));
    ########################################################
    # Defining the symmetry operator whose correlation we want to calculate:
    ########################################################
    Xi=copy(kronecker(Z,kronecker(I(localdim),(dim-1))));
    
    #Xi=copy(kronecker(X,(dim)));
    Corr=abs.(conj(transpose(EigvecNew[2]))*Xi*EigvecNew[2])
    Corr_detu=offdiag(Corr)
    
Corr_detu


end


################################
# Detuning with maximal overlap
################################

function Detuning_Max(EigvecNewA, U_Dressed)

    Corr=fill(0.0, size(U_Dressed));
    Corr_max=fill(0.0, size(EigvecNewA));
    Corr_ind=Int64[];

    EigvecNewB=phase_ordered_eigvecs(U_Dressed)[2];
    
    Corr=abs.(conj(transpose(EigvecNewB))*EigvecNewA)
    for i in 1:size(U_Dressed)[1]
        Corr_max[i]=maximum(Corr[i,:])
        push!(Corr_ind,argmax(Corr[i,:]))
    end
    
return Corr_ind,Corr_max


end
