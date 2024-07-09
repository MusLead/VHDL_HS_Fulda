"""
Just a visualisation of the collision 
detection between the ball and the rackets.
The ball changes color when it hits one of the rackets or walls.

prequisites:
- pygame
- python3 (using dictionary: version 3.7 higher)
"""
import pygame

pygame.init()

def check_collision(x1,y1,w1,h1,x2,y2,w2,h2):
    
    # Check if the squares intersect
    return (x1 <= x2 + w2 and
        x1 + w1 >= x2 and
        y1 <= y2 + h2 and
        y1 + h1 >= y2)
    

def colorize_box(screen, target, box1, box2, color):
    if target == box1 or target == box2:
        pygame.draw.rect(screen, color, box1) 
        pygame.draw.rect(screen, color, box2)
    else:
        pygame.draw.rect(screen, "purple", target)

def collision_detection(screen, boxes, racket_l, racket_r, ball):
    for box in boxes.values():
        if check_collision(racket_l.x, racket_l.y, racket_l.width, racket_l.height, ball.x, ball.y, ball.width, ball.height):
            if check_collision(racket_l.x, racket_l.y + 0, racket_l.width, 6, ball.x, ball.y, ball.width, ball.height):
                colorize_box(screen, box, racket_l, ball, "yellow")  
            elif check_collision(racket_l.x, racket_l.y + 6, racket_l.width, 6, ball.x, ball.y, ball.width, ball.height):
                colorize_box(screen, box, racket_l, ball, "green")
            elif check_collision(racket_l.x, racket_l.y + 12, racket_l.width, 6, ball.x, ball.y, ball.width, ball.height):
                colorize_box(screen, box, racket_l, ball, "aqua")
            elif check_collision(racket_l.x, racket_l.y + 18, racket_l.width, 6, ball.x, ball.y, ball.width, ball.height):
                colorize_box(screen, box, racket_l, ball, "green")
            elif check_collision(racket_l.x, racket_l.y + 24, racket_l.width, 6, ball.x, ball.y, ball.width, ball.height):
                colorize_box(screen, box, racket_l, ball, "yellow")
        elif check_collision(ball.x, ball.y, ball.width, ball.height, racket_r.x, racket_r.y, racket_r.width, racket_r.height):
            if check_collision(racket_r.x, racket_r.y + 0, racket_r.width, 6, ball.x, ball.y, ball.width, ball.height):
                colorize_box(screen, box, racket_r, ball, "yellow")  
            elif check_collision(racket_r.x, racket_r.y + 6, racket_r.width, 6, ball.x, ball.y, ball.width, ball.height):
                colorize_box(screen, box, racket_r, ball, "green")
            elif check_collision(racket_r.x, racket_r.y + 12, racket_r.width, 6, ball.x, ball.y, ball.width, ball.height):
                colorize_box(screen, box, racket_r, ball, "aqua")
            elif check_collision(racket_r.x, racket_r.y + 18, racket_r.width, 6, ball.x, ball.y, ball.width, ball.height):
                colorize_box(screen, box, racket_r, ball, "green")
            elif check_collision(racket_r.x, racket_r.y + 24, racket_r.width, 6, ball.x, ball.y, ball.width, ball.height):
                colorize_box(screen, box, racket_r, ball, "yellow")
        else:
            if ball.x == 0:
                pygame.draw.rect(screen, "red", ball)
            elif (ball.x + ball.width) >= 640 - 1:
                pygame.draw.rect(screen, "DeepPink", ball)
            elif ball.y == 0:
                pygame.draw.rect(screen, "LightBlue", ball)
            elif (ball.y + ball.height) >= 480 - 1:
                pygame.draw.rect(screen, "LightSkyBlue", ball)
            else:
                pygame.draw.rect(screen, "purple", ball)
        
        if box != ball:
            pygame.draw.rect(screen, "purple", box)


def draw_coordinates(screen, boxes, font):
    y_offset = SCREEN_HEIGHT - 60
    for i, box in boxes.items():
        text_surface = font.render(f'{i}: x={box.x}, y={box.y}', True, (255, 255, 255))
        screen.blit(text_surface, (10, y_offset))
        y_offset += 20

#game window
SCREEN_WIDTH = 640
SCREEN_HEIGHT = 480

screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
pygame.display.set_caption('Drag And Drop Ping Pong Squares')

active_box = None
boxes = {}

racket_l = pygame.Rect(20, 50, 10, 30)
racket_r = pygame.Rect(610, 50, 10, 30)
ball = pygame.Rect(320, 240, 10, 10)
boxes["racket_l"] = racket_l
boxes["racket_r"] = racket_r
boxes["ball"] = ball

# Font for displaying coordinates
font = pygame.font.Font(None, 24)

run = True

while run:

  screen.fill("SteelBlue")

  collision_detection(screen, boxes, racket_l, racket_r, ball)
  draw_coordinates(screen, boxes, font)

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