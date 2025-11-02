
#Defining the Basic Logic Gates as Matrices

#The X,Y,Z gates:

X = [0 1 ; 1 0 ];
Y = [0 -1im ; im 0 ];
Z = [1 0 ; 0 -1 ];

# The Hadamard and the Phase Gates:

H=1/sqrt(2)*[1 1 ; 1 -1];
S=[1 0; 0 im];
T=[1 0; 0 exp(im*pi/4)];


#The finite X,Y,Z Rotations:


function RX(r)
    exp(-im*r/2*X)
end


function RY(r)
    exp(-im*r/2*Y)
end


function RZ(r)
    exp(-im*r/2*Z)
end


#The two-body gates:

CNOT=[1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0];
REVCNOT=kron(H, H)*CNOT*kron(H, H)
CZ=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 -1];
SWAP=[1 0 0 0; 0 0 1 0; 0 1 0 0; 0 0 0 1];
;