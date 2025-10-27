using ITensors
ITensors.disable_warn_order()


# dependencies

include("../gates/gates.jl")
include("../functions/kron.jl")


########################################################
# The Brickwall as a Function 
########################################################

# For now we restrict to spin 1/2 systems, i.e. q-dits with level=2
 

function brickwall(FU::Array{Array{ComplexF64,2},1})
        L=length(FU)
        
        Indodd=collect(1:2:L-1);    
        Indeven=collect(2:2:L-1);    
        
        # for even L

        if L%2==0
           

        UOdd=copy(kron_list(FU,Indodd));
        UEven=copy(kron(I(2),kron_list(FU,Indeven),I(2)));
 
        end

        # for odd L

        if L%2==1
        
        UOdd=copy(kron(kron_list(FU,Indodd)),I(2));
        UEven=copy(kron(I(2),kron_list(FU,Indeven)));
        end
            
        A=UEven*UOdd;   

 A    
end
;


#check header

########################################################
# The Brickwall as a Function 
########################################################

# For now we restrict to spin 1/2 systems, i.e. q-dits with level=2
 


########################################################

# The Brickwall as a Tensor Function
# format

# |     |     |     |     |     |     |     |  
#---------------------------------------------
#       |  2  |     |  4  |     |  6  |         
#---------------------------------------------
# |  1  |     |  3  |     |  5  |     |  7  |
#---------------------------------------------
# |     |     |     |     |     |     |     |

########################################################


function brickwall_tensor(L,thetamean,epsilon)

end
;





