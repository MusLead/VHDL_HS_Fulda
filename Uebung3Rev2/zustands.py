import pandas as pd
from sympy.logic import SOPform
import re # Import the regular expression module for sorting variables within parentheses
from sympy import symbols

# Load the CSV file into a DataFrame
df = pd.read_csv('Zustand_MDC.csv')

def get_dnf_terms(df, output_col):
    terms = []

    for index, row in df.iterrows():
        if row[output_col] == 1:
            # print(df.columns[:-4])
            binary_string = ''.join([str(row[col]) for col in df.columns[:-4]])
            terms.append(int(binary_string, 2))
    return terms

def sympy_expr_to_arithmetic_string(expr):
    # Remove spaces
    expr_str = str(expr).replace(' ', '')
    
    # Replace '&' with concatenation (removal of '&')
    expr_str = expr_str.replace('&', '')
    
    # Replace '|' with '+'
    expr_str = expr_str.replace('|', '+')
    
    # Replace '~' with '!'
    expr_str = expr_str.replace('~', '!')

    # # Sort variables alphabetically within parentheses
    def sort_vars(expr_str):
        # Use regular expression to find and sort variables within parentheses
        pattern = re.compile(r'(!\w)|(\w)')
        matches = pattern.findall(expr_str)
        sorted_vars = sorted(matches, key=lambda x: x[1] if x[0] == '' else x[0][1])
        sorted_expr = ''.join(''.join(var) for var in sorted_vars)
        return sorted_expr
    
    expr_str = re.sub(r'\((.*?)\)', lambda match: f"({sort_vars(match.group(1))})", expr_str)
    
    
    return expr_str

def sympy_expr_to_VHDL_logic_string(expr):

    expr_str = str(expr)
    
    # Replace '&' with concatenation (removal of '&')
    expr_str = expr_str.replace('&', 'and')
    
    # Replace '|' with '+'
    expr_str = expr_str.replace('|', 'or')
    
    # Replace '!' with 'not(...)'
    expr_str = re.sub(r'~(\w+)', r'not(\1)', expr_str)
    
    return expr_str


# Compute the DNF terms for each output column (a1, b1, c1, d1)
dnf_terms_d1 = get_dnf_terms(df, 'd1')
dnf_terms_c1 = get_dnf_terms(df, 'c1')
dnf_terms_b1 = get_dnf_terms(df, 'b1')
dnf_terms_a1 = get_dnf_terms(df, 'a1')

print('d1:', dnf_terms_d1)
print('c1:', dnf_terms_c1)  
print('b1:', dnf_terms_b1)  
print('a1:', dnf_terms_a1)  

print('----------------------------------------')

# Define the input variables
U, D, C, B, A = symbols('u d c b a')
inputs = [U, D, C, B, A]
# Compute the DNF expressions for each output column
dnf_a1 = SOPform(inputs, dnf_terms_d1)
dnf_b1 = SOPform(inputs, dnf_terms_c1)
dnf_c1 = SOPform(inputs, dnf_terms_b1)
dnf_d1 = SOPform(inputs, dnf_terms_a1)

# Print the DNF expressions
print('d1:', dnf_d1)
print('c1:', dnf_c1)
print('b1:', dnf_b1)
print('a1:', dnf_a1)

# Convert the DNF expressions to a custom string format
dnf_d1_arithmetic = sympy_expr_to_arithmetic_string(dnf_d1)
dnf_c1_arithmetic = sympy_expr_to_arithmetic_string(dnf_c1)
dnf_b1_arithmetic = sympy_expr_to_arithmetic_string(dnf_b1)
dnf_a1_arithmetic = sympy_expr_to_arithmetic_string(dnf_a1)

print('----------------------------------------')
# Print the airthmetic string format of the DNF expressions
print('d1 (custom and sorted):', dnf_d1_arithmetic,)
print('c1 (custom and sorted):', dnf_c1_arithmetic)
print('b1 (custom and sorted):', dnf_b1_arithmetic)
print('a1 (custom and sorted):', dnf_a1_arithmetic)

print('----------------------------------------')
# Print the custom string format of the DNF expressions
dnf_d1_vhdl = sympy_expr_to_VHDL_logic_string(dnf_d1)
dnf_c1_vhdl = sympy_expr_to_VHDL_logic_string(dnf_c1)
dnf_b1_vhdl = sympy_expr_to_VHDL_logic_string(dnf_b1)   
dnf_a1_vhdl = sympy_expr_to_VHDL_logic_string(dnf_a1)

print('d1 (VHDL):', dnf_a1_vhdl, '\n')
print('c1 (VHDL):', dnf_b1_vhdl, '\n')
print('b1 (VHDL):', dnf_c1_vhdl, '\n')
print('a1 (VHDL):', dnf_d1_vhdl, '\n')

