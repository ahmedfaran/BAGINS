tic
clc

rng('default');
rng(1);

% Define Experimental Conditions to Generate Numerical DataSet
MatrixSizes = [3 7 11 15];
BetaParameters = [0 0.2 0.4 0.6 0.8 1.00];
iter = 200;

% Parameterize the Experimental Conditions
Parameters.MatrixSizes = MatrixSizes;
Parameters.BetaParameters = BetaParameters;
Parameters.iter = iter;

[FinalDataSet, CompleteData] = GenerateDataSet(Parameters);

[m, ~] = size(FinalDataSet);
CompatibilityIndex = cell(m,1);

SaatyScale = [1/9 1/8 1/7 1/6 1/5 1/4 1/3 1/2 1 ...
                    2.00 3.00 4.00 5.00 6.00 7.00 8.00 9.00];
cut = 6;
ExcelFile = cell(m,15);
                
for i = 1:m

NPCM        = FinalDataSet{i,5};
LPCM        = NPCMtoLPCM(NPCM, SaatyScale);
TrueWeights = FinalDataSet{i,6};

[K, ~] = size(NPCM);
TrueWeightMatrix = zeros(K,K);
for p = 1:K
    for q = 1:K
    TrueWeightMatrix(p,q) = TrueWeights(p)./TrueWeights(q);       
    end
end

% Based on Heurisitc Proposed by Kemal Hoca 
%[KilicScale, ~] = KilicHeuristicScale(LPCM, cut);
%KilicHeuristicNPCM = LPCMtoCrispNPCM(LPCM,KilicScale);

% Based on Saaty Scale of 1 - 9
tic
OriginalNPCM = LPCMtoCrispNPCM(LPCM,SaatyScale);
timeS1 = toc;
% Based on NLP Model of Dong
tic
LPModelScale = IndividualizeScale(LPCM);
LPModelNPCM = LPCMtoCrispNPCM(LPCM, LPModelScale);
timeNLP1 = toc;
tic
% Based on BAGINS   
[BAGINS_Scale] = BAGINS(LPCM);
NonPolarizedNPCM = LPCMtoCrispNPCM(LPCM,BAGINS_Scale);
timeB1 = toc;
%ExcelFile{i,1}          = CalculateConsistency(KilicHeuristicNPCM);
%CrispWeights            = Eigenvector(KilicHeuristicNPCM);
%NormalizedCrispWeights  = CrispWeights/sum(CrispWeights);
%ExcelFile{i,2}          = Compatibility(KilicHeuristicNPCM, NormalizedCrispWeights);
%ExcelFile{i,3}          = Compatibility(TrueWeightMatrix, NormalizedCrispWeights);
tic
%BAGINS (2022) 
%ExcelFile{i,5}          = CalculateConsistency(NonPolarizedNPCM);
CrispWeights            = Eigenvector(NonPolarizedNPCM);
timeB2 = toc;
NormalizedCrispWeights  = CrispWeights/sum(CrispWeights);
ExcelFile{i,6}          = Compatibility(NonPolarizedNPCM, NormalizedCrispWeights);
ExcelFile{i,7}          = Compatibility(TrueWeightMatrix, NormalizedCrispWeights);
ExcelFile{i,8}          = Compatibility(NonPolarizedNPCM, TrueWeights);

tic
%Saaty (1977)
%ExcelFile{i,9}          = CalculateConsistency(OriginalNPCM);
CrispWeights            = Eigenvector(OriginalNPCM);
timeS2 = toc;
NormalizedCrispWeights  = CrispWeights/sum(CrispWeights);
ExcelFile{i,10}         = Compatibility(OriginalNPCM, NormalizedCrispWeights);
ExcelFile{i,11}         = Compatibility(TrueWeightMatrix, NormalizedCrispWeights);
ExcelFile{i,12}          = Compatibility(OriginalNPCM, TrueWeights);

tic
%Dong (2013) 
%ExcelFile{i,13}         = CalculateConsistency(LPModelNPCM);
CrispWeights            = Eigenvector(LPModelNPCM);
timeNLP2 = toc;
NormalizedCrispWeights  = CrispWeights/sum(CrispWeights);
ExcelFile{i,14}         = Compatibility(LPModelNPCM, NormalizedCrispWeights);
ExcelFile{i,15}         = Compatibility(TrueWeightMatrix, NormalizedCrispWeights);
ExcelFile{i,16}          = Compatibility(LPModelNPCM, TrueWeights);


%SIH (2022) with geomean 
%ExcelFile{i,5}          = CalculateConsistency(NonPolarizedNPCM);
CrispWeights            = geomean(NonPolarizedNPCM')';
NormalizedCrispWeights  = CrispWeights/sum(CrispWeights);
ExcelFile{i,17}          = Compatibility(NonPolarizedNPCM, NormalizedCrispWeights);
ExcelFile{i,18}          = Compatibility(TrueWeightMatrix, NormalizedCrispWeights);
ExcelFile{i,19}          = Compatibility(NonPolarizedNPCM, TrueWeights);

ExcelFile{i,20} = timeS1;
ExcelFile{i,21} = timeS2;
ExcelFile{i,22} = timeNLP1;
ExcelFile{i,23} = timeNLP2;
ExcelFile{i,24} = timeB1;
ExcelFile{i,25} = timeB2;



i

end

toc