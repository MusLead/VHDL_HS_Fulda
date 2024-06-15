import pandas as pd
from sympy.logic import SOPform
import re # Import the regular expression module for sorting variables within parentheses
from sympy import symbols

# Load the CSV file into a DataFrame
df = pd.read_csv('Zustandsdigram.csv')

import pandas as pd

# Load the CSV file into a DataFrame
df = pd.read_csv('Zustandsdigram.csv')

def get_dnf_terms(df, output_col):
    terms = []

    for index, row in df.iterrows():
        if row[output_col] == 1:
            print(df.columns[:-4])
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


# Compute the DNF terms for each output column (d0, d1, d2, d3)
dnf_terms_d0 = get_dnf_terms(df, 'd0')
dnf_terms_d1 = get_dnf_terms(df, 'd1')
dnf_terms_d2 = get_dnf_terms(df, 'd2')
dnf_terms_d3 = get_dnf_terms(df, 'd3')

print('d0:', dnf_terms_d0)
print('d1:', dnf_terms_d1)  
print('d2:', dnf_terms_d2)  
print('d3:', dnf_terms_d3)  

print('----------------------------------------')

# Define the input variables
A, B, C, D, U = symbols('A B C D U')

# Compute the DNF expressions for each output column
dnf_d0 = SOPform([A, B, C, D, U], dnf_terms_d0)
dnf_d1 = SOPform([A, B, C, D, U], dnf_terms_d1)
dnf_d2 = SOPform([A, B, C, D, U], dnf_terms_d2)
dnf_d3 = SOPform([A, B, C, D, U], dnf_terms_d3)

# Print the DNF expressions
print('d0:', dnf_d0)
print('d1:', dnf_d1)
print('d2:', dnf_d2)
print('d3:', dnf_d3)

# Convert the DNF expressions to a custom string format
dnf_d0_arithmetic = sympy_expr_to_arithmetic_string(dnf_d0)
dnf_d1_arithmetic = sympy_expr_to_arithmetic_string(dnf_d1)
dnf_d2_arithmetic = sympy_expr_to_arithmetic_string(dnf_d2)
dnf_d3_arithmetic = sympy_expr_to_arithmetic_string(dnf_d3)

print('----------------------------------------')
# Print the airthmetic string format of the DNF expressions
print('d0 (custom and sorted):', dnf_d0_arithmetic,)
print('d1 (custom and sorted):', dnf_d1_arithmetic)
print('d2 (custom and sorted):', dnf_d2_arithmetic)
print('d3 (custom and sorted):', dnf_d3_arithmetic)

print('----------------------------------------')
# Print the custom string format of the DNF expressions
dnf_d0_vhdl = sympy_expr_to_VHDL_logic_string(dnf_d0)
dnf_d1_vhdl = sympy_expr_to_VHDL_logic_string(dnf_d1)
dnf_d2_vhdl = sympy_expr_to_VHDL_logic_string(dnf_d2)   
dnf_d3_vhdl = sympy_expr_to_VHDL_logic_string(dnf_d3)

print('d0 (VHDL):', dnf_d0_vhdl, '\n')
print('d1 (VHDL):', dnf_d1_vhdl, '\n')
print('d2 (VHDL):', dnf_d2_vhdl, '\n')
print('d3 (VHDL):', dnf_d3_vhdl, '\n')

