function projector_down(Psi::Vector{ComplexF64}, ind::Int)
 
 L=Int(log(length(Psi))/log(2))
 Ldown=ind-1;
 LUp=L-ind


 Psi=reshape(Psi, (2^Ldown,2,2^LUp))
 Psi=permutedims(Psi, (1,3,2))
 Psi=reshape(Psi, (2^(Ldown+LUp), 2))
 Psi=Psi*[0 0; 0 1];
 Psi=reshape(Psi, (2^Ldown,2^LUp,2))
 Psi=permutedims(Psi, (1,3,2))
 Psi=reshape(Psi, (2^L))
 
Psi=Psi/norm(Psi)

return Psi

end




function projector_up(Psi::Vector{ComplexF64}, ind::Int)
 
 L=Int(log(length(Psi))/log(2))
 Ldown=ind-1;
 LUp=L-ind


 Psi=reshape(Psi, (2^Ldown,2,2^LUp))
 Psi=permutedims(Psi, (1,3,2))
 Psi=reshape(Psi, (2^(Ldown+LUp),2 ))
 Psi=Psi*[1 0; 0 0];
 Psi=reshape(Psi, (2^Ldown,2^LUp,2))
 Psi=permutedims(Psi, (1,3,2))
 Psi=reshape(Psi, (2^L))
 
Psi=Psi/norm(Psi)

return Psi

end


function projectatt(Psi::Vector{ComplexF64}, indlist::Array{Int})

global Psi

for (i,n) in enumerate(indlist)
    Psi=projector_down(Psi,n)
end

return Psi

end