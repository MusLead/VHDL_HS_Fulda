def do_squares_intersect(square1, square2):
    """
    Check if two squares intersect.

    Each square is represented by a dictionary with the following keys:
    - 'cx': the x-coordinate of the center
    - 'cy': the y-coordinate of the center
    - 'size': the side length of the square

    :param square1: A dictionary representing the first square.
    :param square2: A dictionary representing the second square.
    :return: True if the squares intersect, False otherwise.
    """
    # Extract the coordinates and sizes of the squares
    cx1, cy1, size1 = square1['cx'], square1['cy'], square1['size']
    cx2, cy2, size2 = square2['cx'], square2['cy'], square2['size']

    # Calculate half sizes
    half_size1 = size1 / 2
    half_size2 = size2 / 2

    # Calculate edges of the first square
    left1 = cx1 - half_size1
    right1 = cx1 + half_size1
    bottom1 = cy1 - half_size1
    top1 = cy1 + half_size1

    # Calculate edges of the second square
    left2 = cx2 - half_size2
    right2 = cx2 + half_size2
    bottom2 = cy2 - half_size2
    top2 = cy2 + half_size2

    # Check if the squares intersect
    if (left1 < right2 and
        right1 > left2 and
        bottom1 < top2 and
        top1 > bottom2):
        return True
    else:
        return False

# Example usage
square1 = {'cx': 0, 'cy': 0, 'size': 2}
square2 = {'cx': 1, 'cy': 1, 'size': 2}

print(do_squares_intersect(square1, square2))  # Output: True