########################################################
#
#functions for computing the
#
#LAZADIRES DIAGRAM
#
#of an Unitary Matrix
########################################################






################################
# Phase ordering
################################


function phase_ordered_eigvecs(EigA,Eigvec)


    #########################################
    # Extracting eigenvalues and eigenvectors of the input matrix A:
    #########################################

    N=angle.(EigA);
    
    #########################################
    # Defining a matrix to store the phase information of the eigenvectors:
    #########################################


    Ph=fill(0.0*im, length(EigA)+1,length(EigA));
    

    

    ########################################################
    # Storing the phase information of the eigenvectors in the matrix Ph:
    ########################################################

    Ph[1,:]=N;
    for i in 1:length(EigA);
        for j in 1:length(EigA)
            Ph[i+1,j]=Eigvec[i,j];
        end
    end
    
    ########################################################
    # Ordering the eigenstates from -pi to pi:
    ########################################################

    Phnew=copy(Ph[:,sortperm(real(Ph[1, :]))]); # Phase orders the eigenstates from -pi to pi
    EigvecNew=Eigvec;
    
    for i in 1:length(EigA);
        for j in 1:length(EigA)
            EigvecNew[i,j]=Phnew[i+1,j];
        end
    end
    
    return EigA,EigvecNew

end

function phase_ordered_eigvecs(A)

    
    #########################################
    # Extracting eigenvalues and eigenvectors of the input matrix A:
    #########################################

    EigA,Eigvec=eigen(A);
    N=angle.(EigA);
    
    #########################################
    # Defining a matrix to store the phase information of the eigenvectors:
    #########################################


    Ph=fill(0.0*im, length(EigA)+1,length(EigA));
    

    

    ########################################################
    # Storing the phase information of the eigenvectors in the matrix Ph:
    ########################################################

    Ph[1,:]=N;
    for i in 1:length(EigA);
        for j in 1:length(EigA)
            Ph[i+1,j]=Eigvec[i,j];
        end
    end
    
    ########################################################
    # Ordering the eigenstates from -pi to pi:
    ########################################################

    Phnew=copy(Ph[:,sortperm(real(Ph[1, :]))]); # Phase orders the eigenstates from -pi to pi
    EigvecNew=Eigvec;
    
    for i in 1:length(EigA);
        for j in 1:length(EigA)
            EigvecNew[i,j]=Phnew[i+1,j];
        end
    end
    
    return EigA,EigvecNew

end


################################
# LazadiresDiagram 
################################



function LazadiresDiagram(U)

    EigvecNew=phase_ordered_eigvecs(U)[2];

    #########################################
    # Extracting Number of qubits from the input matrix A:
    #########################################

   
    localdim=length(eigvals(Z));
    dim=convert(Int64,floor(log(size(EigvecNew)[1])/log(localdim)))


    ########################################################
    # Constructing the correlation matrix:
    ########################################################

    Corr=fill(0.0, size(EigvecNew));
    
    ########################################################
    # Defining the symmetry operator whose correlation we want to calculate:
    ########################################################
    
    Xi=copy(kron(Z,kron_power(I(localdim),(dim-1))));
    Corr=real.(conj(transpose(EigvecNew))*Xi*EigvecNew)
    
Corr


end

include("off-and-diagonals.jl")
include("lazadires_diagram_plots.jl")