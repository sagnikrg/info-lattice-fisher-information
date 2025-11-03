### functions for level spacing and level spacing ratio 
###
### including one for directly generating the histogram plot


### functions for building eigenstatics



################################
# Level Spacing Statistics
################################ 


function LevelSpacing(EigA)

    N=fill(0.0,length(EigA))        # N is the array of eigenvalues
   
    N=angle.(EigA);                 # N is the array of eigenvalues in angle form
    N= sort(N,rev=true);            # N is the array of eigenvalues in angle form in descending order
    EigA1=copy(N);                  # EigA1 is the array of eigenvalues in angle form in descending order
   
    ls = deleteat!(EigA1,1);        # ls is the array of eigenvalues in angle form in descending order without the first element
    la = deleteat!(N,length(N));    # la is the array of eigenvalues in angle form in descending order without the last element            
    
    m=copy(la-ls)/mean(la-ls);      # m is the array of level spacing statistics

    m

end    


function LevelSpacingRatio(EigA)

    N=fill(0.1,length(EigA))
    N=angle.(EigA);

    N= sort(N,rev=true);


    EigA1=copy(N);
    ls = deleteat!(EigA1,1);
    la = deleteat!(N,length(N));
    m=copy(la-ls)/mean(la-ls)

    #histogram(m)

    #Computing Level Spacing Ratio

    n=fill(0.1,length(EigA)-2);

        for i in 1:length(n)
            #n[i]=m[i+1]/m[i];
            n[i]= minimum([m[i], m[i+1]])/maximum([m[i], m[i+1]]);
        end

    #histogram(n)
    #mean(n)
    n
end    