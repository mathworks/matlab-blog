function [results] = blasBench(maxN,stepN,repeats)
fprintf("BLAS bench with matrices from %d:%d in steps of %d\n",stepN,maxN,stepN)
fprintf("Each benchmark will be repeated %d times and the results averaged\n",repeats)
blas = version('-blas')
lapack = version('-lapack')

numResults = maxN/stepN;
resultNumber = 1;
matMulResults = zeros(numResults,repeats);
cholResults = zeros(numResults,repeats);
luResults = zeros(numResults,repeats);
eigResults = zeros(numResults,repeats);
for N=stepN:stepN:maxN
    fprintf("Working on matrices of size %d x %d\n",N,N)
    a = rand(N);
    b = rand(N);
    cholmat = a*a';

    for count=1:repeats
        %Matrix-Matrix multiplication
        tic
        c = a*b;
        matMulResults(resultNumber,count) = toc;
        
        %cholesky
        tic
        R = chol(cholmat);
        cholResults(resultNumber,count) = toc;

        %LU factorisation
        tic
        L = lu(a);
        luResults(resultNumber,count) = toc;

        % eig
        tic
        e = eig(a);
        eigResults(resultNumber,count) = toc;
    end
    resultNumber = resultNumber+1;
end



% Put results into a table
matsize = stepN:stepN:maxN;
varNames = ["N","MatMul","chol","lu","eig"];
results = table(matsize',mean(matMulResults,2),mean(cholResults,2), ...
          mean(luResults,2),mean(eigResults,2),VariableNames=varNames);
disp("Script done")
end