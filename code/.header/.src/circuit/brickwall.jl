

# dependencies

include("../gates/gates.jl")
include("../functions/kron.jl")

####################################################
# Brickwall as feed for ITensors
# 
# run tests on the order of legs of these tensors 
####################################################


function brickwall_tensor(FU::Array{Array{ComplexF64,2},1})

FUTensor=fill(fill(0.0*im, 2,2,2,2), length(FU));

for i in 1:length(FU)
      FUTensor[i]=reshape(FU[i],2,2,2,2)
end
 
# Returning Brickwall:        
FUTensor

end
;




########################################################
# The Brickwall as a Function 
########################################################

# For now we restrict to spin 1/2 systems, i.e. q-dits with level=2
 

function brickwall(FU::Array{Array{ComplexF64,2},1})
        L=length(FU)+1;
        
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



