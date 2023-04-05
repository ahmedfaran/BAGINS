v = [0.4000; 0.3000; 0.2000; 0.0500; 0.0500]; 

L = [   9	10	11	15  16
        8	9	10	13  14 
        7	8	9	14  13
        3	5	4	9   12
        2   4   5   6   9
    ];
 
SaatyScale = [1/9 1/8 1/7 1/6 1/5 1/4 1/3 1/2 1 ...
                    2.00 3.00 4.00 5.00 6.00 7.00 8.00 9.00];           
                
A = LPCMtoCrispNPCM(L, SaatyScale);
w_Saaty = Eigenvector(A); 
w_Saaty = w_Saaty/sum(w_Saaty);

[K, ~] = size(A);
W_Matrix = zeros(K,K);
for p = 1:K
    for q = 1:K
    W_Matrix(p,q) = w_Saaty(p)./w_Saaty(q);       
    end
end

v_MAtrix = zeros(K,K);
for p = 1:K
    for q = 1:K
    v_MAtrix(p,q) = v(p)./v(q);       
    end
end


TruthScale = [0.08	0.11	0.13	0.17	0.20	0.40	0.50	0.67 ...
                    1.00	1.50	2.00	2.50	5.00	6.00	8.00	9.00	12.00];  
                
                	
                
A_Truth = LPCMtoCrispNPCM(L, TruthScale);
w_Truth = Eigenvector(A_Truth); 
w_Truth = w_Truth/sum(w_Truth);

[K, ~] = size(A_Truth);
W_Matrix_Truth = zeros(K,K);
for p = 1:K
    for q = 1:K
    W_Matrix_Truth(p,q) = w_Truth(p)./w_Truth(q);       
    end
end

[NonPolarizedScale] = WithOutPolarization(L);
NonPolarizedNPCM = LPCMtoCrispNPCM(L,NonPolarizedScale);
w_ind            = Eigenvector(NonPolarizedNPCM);
w_ind            = w_ind/sum(w_ind);

[K, ~] = size(A);
W_Matrix_ind = zeros(K,K);
for p = 1:K
    for q = 1:K
    W_Matrix_ind(p,q) = w_ind(p)./w_ind(q);       
    end
end

GCIV_AV_Saaty = Compatibility(A,v);
GCIV_VW_Saaty = Compatibility(W_Matrix,v);
GCIV_AW_Saaty = Compatibility(A,w_Saaty);

GCIV_AV_Truth = Compatibility(A_Truth,v);
GCIV_VW_Truth = Compatibility(W_Matrix_Truth,v);
GCIV_AW_Truth = Compatibility(A_Truth,w_Truth);


GCIV_AV_Ind = Compatibility(NonPolarizedNPCM,v);
GCIV_VW_ind = Compatibility(W_Matrix_ind,v);
GCIV_AW_ind = Compatibility(NonPolarizedNPCM,w_ind);

CR_Saaty = CalculateConsistency(A);
CR_Truth = CalculateConsistency(A_Truth);
CR_Ind = CalculateConsistency(NonPolarizedNPCM);

[~, D]   = eig(A);
[maxLambdaValue, ~] = max(diag(D));