%% Partial Fraction Expansion
% Define the numerator and denominator coefficients
b = [20, 261, 1116, 1543];
a = [4,59,311,685,525];

% Ask the user to input b and a
%b = input('Enter the numerator coefficients, [a,b,c]: ');
%a = input('Enter the denominator coefficients, [a,b,c]: ');

% Compute the partial fraction expansion coefficients
[r, p, k] = residue(b, a)

% Create a symbolic variable for 's'
syms s;

% Initialize the equation string
eqn_str = '';

% Loop over each partial fraction term
for i = 1:length(r)
    % Check if the pole is at infinity
    if isinf(p(i))
        % If the pole is at infinity, the partial fraction term is just a constant
        term_str = sprintf('%.4f/s', r(i));
    else
        % If the pole is not at infinity, the partial fraction term is a proper fraction
        term_str = sprintf('%.4f/(s-(%.4f))', r(i), p(i));
    end
    
    % Add the partial fraction term to the equation string
    if i == 1
        % If this is the first term, don't include a plus sign
        eqn_str = term_str;
    else
        % If this is not the first term, include a plus sign
        eqn_str = sprintf('%s + %s', eqn_str, term_str);
    end
end

% Add the constant term to the equation string
if k ~= 0
    eqn_str = sprintf('%s + %.4f', eqn_str, k);
end

% Display the final equation
disp(eqn_str)

%% Inverse Laplace transform of the partial fraction expansion
syms s t;
G = eqn_str;

% Convert G to a symbolic expression
G_sym = str2sym(G);

% Compute the inverse Laplace transform
g = ilaplace(G_sym, s, t);

% Display the inverse Laplace transform
disp(g)