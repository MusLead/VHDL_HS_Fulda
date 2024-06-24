import csv

def generate_truth_table(n):
    # Calculate the total number of rows in the truth table (2^n)
    num_rows = 2 ** n
    
    # Generate the truth table
    truth_table = []
    for i in range(num_rows):
        row = [(i >> bit) & 1 for bit in range(n-1, -1, -1)]
        truth_table.append(row)
    
    return truth_table

def save_truth_table_to_csv(truth_table, filename):
    with open(filename, mode='w', newline='') as file:
        writer = csv.writer(file)
        writer.writerows(truth_table)

# Example usage
n = int(input("Enter the number of bits: "))
truth_table = generate_truth_table(n)
filename = "truth_table.csv"
save_truth_table_to_csv(truth_table, filename)
print(f"Truth table saved to {filename}")
