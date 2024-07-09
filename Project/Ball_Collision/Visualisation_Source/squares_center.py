import pygame

pygame.init()

pygame.display.set_caption('Drag And Drop collision detection (center point)')

#game window
SCREEN_WIDTH = 640
SCREEN_HEIGHT = 480

def do_squares_intersect(square1, square2, font, screen):
    """
    Check if two squares intersect.
    :param square1: A dictionary representing the first square.
    :param square2: A dictionary representing the second square.
    :return: True if the squares intersect, False otherwise.
    """

    # Extract the coordinates and sizes of the squares
    if square1.width == square1.height and square2.width == square2.height:
        size1 = square1.width
        size2 = square2.width
    else:
        raise ValueError("Squares are not a square" if square1.width != square1.height and square2.width != square2.height else ("square1 is not a square" if square1.width != square1.height else "square2 is not a square"))
    
    # WARNING! These coordinates is being calculated 
    # because the square is drawn from the top-left corner
    # If the square is drawn from the center, 
    # the coordinates does not need to be calculated
    cx1, cy1 = square1.x + size1/2, square1.y + size1/2
    cx2, cy2 = square2.x + size2/2, square2.y + size2/2

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

    # MAIN LOGIC: Check if the squares intersect
    # TODO: ask yourself/myself why this works, how can we explain this with only 2 lines?
    # will that make it easier to understand?
    e1 = left1 <= right2
    e2 = right1 >= left2
    e3 = bottom1 <= top2
    e4 = top1 >= bottom2
    collision = e1 and e2 and e3 and e4

    # Coordinate relations
    display_text = {
        f"x1 ({cx1}) <= x2 ({cx2}) + size2 ({size2})" if e1 else f"x1 ({cx1}) > x2 ({cx2}) + size2 ({size2})" : e1,
        f"x1 ({cx1}) + size1 ({size1}) >= x2 ({cx2})" if e2 else f"x1 ({cx1}) + size1 ({size1}) < x2 ({cx2})" : e2,
        f"y1 ({cy1}) <= y2 ({cy2}) + size2 ({size2})" if e3 else f"y1 ({cy1}) > y2 ({cy2}) + size2 ({size2})" : e3,
        f"y1 ({cy1}) + size1 ({size1}) >= y2 ({cy2})" if e4 else f"y1 ({cy1}) + size1 ({size1}) < y2 ({cy2})" : e4
    }
    y_offset = 10
    
    # Display the text of coordinates relation on the screen
    for text, isFullfilled in display_text.items():
        if isFullfilled:
            text_surface = font.render(text, True, (0, 255, 0))
        else:
            text_surface = font.render(text, True, (255, 255, 255))
        screen.blit(text_surface, (10, y_offset))
        y_offset += 20

    # Check if the squares intersect
    return collision

def draw_coordinates(screen, boxes, font):
    y_offset = SCREEN_HEIGHT - 60
    for i, box in boxes.items():
        text_surface = font.render(f'{i}: x={box.x}, y={box.y}', True, (255, 255, 255))
        screen.blit(text_surface, (10, y_offset))
        y_offset += 20

# Example usage
boxes = {}
active_box = None
size = 100
boxes["s1"] = pygame.Rect(20, 100, size, size)
boxes["s2"] = pygame.Rect(250, 100, size, size)

screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))

run = True

# Font for displaying coordinates
font = pygame.font.Font(None, 24)

while run:

  screen.fill("SteelBlue")

  if do_squares_intersect(boxes["s1"], boxes["s2"], font, screen):
    pygame.draw.rect(screen, (0, 255, 0), boxes["s1"])
    pygame.draw.rect(screen, (0, 255, 0), boxes["s2"])
  else:
    pygame.draw.rect(screen, (255, 255, 255), boxes["s1"])
    pygame.draw.rect(screen, (255, 255, 255), boxes["s2"])

  
  draw_coordinates(screen, boxes, font)

  # WARNING! These coordinates is being calculated 
  # because the square is drawn from the top-left corner
  # If the square is drawn from the center, 
  # the coordinates does not need to be calculated

  # Draw the (x,y) coordinates of the squares
  for box in boxes.values():
    x, y = box.x, box.y
    pygame.draw.circle(screen, "Purple", (x + box.width/2, y + box.height/2), 5)

  for event in pygame.event.get():
    if event.type == pygame.MOUSEBUTTONDOWN:
        if event.button == 1:
            for key, box in boxes.items():
                if box.collidepoint(event.pos):
                    active_box = key

    if event.type == pygame.MOUSEBUTTONUP:
        if event.button == 1:
            active_box = None

    if event.type == pygame.MOUSEMOTION:
        if active_box is not None:
            # Move the active box within the screen boundaries
            new_x = boxes[active_box].x + event.rel[0]
            new_y = boxes[active_box].y + event.rel[1]
            if new_x >= 0 and new_x + boxes[active_box].width <= SCREEN_WIDTH:
                boxes[active_box].x = new_x
            if new_y >= 0 and new_y + boxes[active_box].height <= SCREEN_HEIGHT:
                boxes[active_box].y = new_y

    if event.type == pygame.QUIT:
      run = False

  pygame.display.flip()

pygame.quit()

