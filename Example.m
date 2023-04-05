tic
NPCMExperimental = [    1.00	1.40	2.13	2.37	3.28	3.34	3.70	1.72	5.46	3.93	1.77
                        0.71	1.00	0.53	1.24	2.05	2.45	0.60	1.91	0.82	1.25	4.53
                        0.47	1.90	1.00	1.34	1.13	0.39	1.19	1.19	3.65	0.69	2.84
                        0.42	0.80	0.75	1.00	1.15	0.86	0.74	1.21	2.22	2.34	1.81
                        0.30	0.49	0.88	0.87	1.00	1.57	0.74	2.76	2.55	0.54	0.58
                        0.30	0.41	2.59	1.17	0.64	1.00	0.38	0.43	1.17	0.87	0.92
                        0.27	1.66	0.84	1.36	1.36	2.61	1.00	1.14	1.32	2.04	2.83
                        0.58	0.52	0.84	0.83	0.36	2.33	0.87	1.00	1.27	1.53	1.53
                        0.18	1.23	0.27	0.45	0.39	0.85	0.76	0.79	1.00	1.49	0.64
                        0.25	0.80	1.46	0.43	1.87	1.15	0.49	0.65	0.67	1.00	0.47
                        0.57	0.22	0.35	0.55	1.73	1.08	0.35	0.65	1.56	2.14	1.00

        ];

SaatyScale = [1/9 1/8 1/7 1/6 1/5 1/4 1/3 1/2 1 ...
                    2.00 3.00 4.00 5.00 6.00 7.00 8.00 9.00];
                
LPCMExperimental = NPCMtoLPCM(NPCMExperimental,SaatyScale);
 
 [NonPolarizedScale] = BAGINS(LPCMExperimental);
 NonPolarizedNPCM = LPCMtoCrispNPCM(LPCMExperimental,NonPolarizedScale);
 
 CrispWeights            = Eigenvector(NonPolarizedNPCM);
 NormalizedCrispWeights  = CrispWeights/sum(CrispWeights);

% LPModelScale = IndividualizeScale(LPCMExperimental);
% LPModelNPCM = LPCMtoCrispNPCM(LPCMExperimental, LPModelScale);
% 
% CrispWeights            = Eigenvector(LPModelNPCM);
% NormalizedCrispWeights  = CrispWeights/sum(CrispWeights);

toc
