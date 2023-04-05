%function [CrispWeights] = Crawford(InconsistentMatrix)

InconsistentMatrix = [1   3   9
                      1/3 1   3 
                      1/9 1/3 1];

B = InconsistentMatrix';

CrispWeightsGeo = geomean(B)';


[V,D] = eig(InconsistentMatrix);
[~, Index] = max(diag(D));
CrispWeights = V(:,Index);

C = CrispWeights/sum(CrispWeights);
%end