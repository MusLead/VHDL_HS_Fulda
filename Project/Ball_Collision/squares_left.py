def do_squares_intersect(square1, square2):
    """
    Check if two squares intersect.

    Each square is represented by a dictionary with the following keys:
    - 'x': the x-coordinate of the bottom-left corner
    - 'y': the y-coordinate of the bottom-left corner
    - 'size': the side length of the square

    :param square1: A dictionary representing the first square.
    :param square2: A dictionary representing the second square.
    :return: True if the squares intersect, False otherwise.
    """
    # Extract the coordinates and sizes of the squares
    x1, y1, size1 = square1['x'], square1['y'], square1['size']
    x2, y2, size2 = square2['x'], square2['y'], square2['size']

    # Check if the squares intersect
    if (x1 <= x2 + size2 and
        x1 + size1 >= x2 and
        y1 <= y2 + size2 and
        y1 + size1 >= y2):
        return True
    else:
        return False

# Example usage
square1 = {'x': 0, 'y': 0, 'size': 2}
square2 = {'x': 1, 'y': 1, 'size': 2}

print(do_squares_intersect(square1, square2))  # Output: True