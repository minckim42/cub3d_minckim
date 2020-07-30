# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: minckim <minckim@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/06/29 16:58:52 by minckim           #+#    #+#              #
#    Updated: 2020/07/30 17:09:38 by minckim          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#output
NAME = cub3d

# compile option
CC = gcc
FLAG = -Wall -Wextra -Werror -O3
# FLAG = -Wall -Wextra -Werror -O3 -g
#FLAG = -O3 -g
# FLAG = -O3

#library
LIBFT_DIR = ./libft/
LIBFT = libft.a

LIBGNL_DIR = $(LIBFT_DIR)get_next_line/
LIBGNL = libgnl.a

LIBFTPRINTF_DIR = $(LIBFT_DIR)ft_printf/
LIBFTPRINTF = libftprintf.a

#source files
SRCS_TEST = main_ex.c
OBJS_TEST = $(SRCS_TEST:.c=.o)

BITMAP_DIR = ./bitmap/
BITMAP_NAME = \
	bitmap.c

SCREEN_DIR = ./screen/
SCREEN_NAME = \
	init_screen.c\
	screen_entity.c\
	screen_face.c\
	screen_face_util.c\
	screen_bitmap.c\
	save_screenshot.c\
	screen_brighten.c\
	screen_exit.c

LINEAR_DIR = ./linear_algebra/
LINEAR_NAME = \
	vec0.c\
	vec1.c\
	vec2.c\
	mat0.c\
	mat1.c\
	mat2.c\
	equation.c\
	equation_line_operation0.c\
	equation_line_operation1.c\
	linear_algebra_print.c

GEOMETRY_DIR = ./geometry/
GEOMETRY_NAME =\
	face0.c\
	face1.c\
	entity.c\
	geometry_print.c\
	stl_to_geometry.c

SRCS_COMMON_DIR = ./srcs_common/
SRCS_COMMON_NAME =\
	init.c\
	init_util.c\
	init_check_map.c\
	print_entities.c\
	main.c\
	put_fps.c\
	init_entity.c\
	init_parse_line.c\
	init_create_entity.c\
	player_manage.c

SRCS_BONUS_DIR = ./srcs_bonus/
SRCS_BONUS_NAME =\
	init.c\
	init_util.c\
	init_check_map.c\
	print_entities.c\
	main.c\
	put_fps.c\
	init_entity.c\
	init_parse_line.c\
	init_create_entity.c\
	player_move_turn.c\
	check_collision.c\
	jump.c\
	crouch.c\
	mouse_motion.c\
	hud.c\
	hud_lifebar.c\
	hud_stand_crouch.c\
	item_interaction.c\
	player_dead.c\
	player_door.c\
	key_manager.c

SRCS = $(addprefix $(SRCS_COMMON_DIR),$(SRCS_COMMON_NAME))\
	$(addprefix $(SCREEN_DIR),$(SCREEN_NAME))\
	$(addprefix $(LINEAR_DIR),$(LINEAR_NAME))\
	$(addprefix $(BITMAP_DIR),$(BITMAP_NAME))\
	$(addprefix $(GEOMETRY_DIR),$(GEOMETRY_NAME))

SRCS_BONUS = $(addprefix $(SRCS_BONUS_DIR),$(SRCS_BONUS_NAME))\
	$(addprefix $(SCREEN_DIR),$(SCREEN_NAME))\
	$(addprefix $(LINEAR_DIR),$(LINEAR_NAME))\
	$(addprefix $(BITMAP_DIR),$(BITMAP_NAME))\
	$(addprefix $(GEOMETRY_DIR),$(GEOMETRY_NAME))

OBJS = $(SRCS:.c=.o)

OBJS_BONUS = $(SRCS_BONUS:.c=.o)

HEADERS = \
	$(SRCS_COMMON_DIR)cub3d_common.h\
	$(SRCS_BONUS_DIR)cub3d_bonus.h\
	$(SCREEN_DIR)screen.h\
	$(LINEAR_DIR)linear_algebra.h\
	$(BITMAP_DIR)bitmap.h\
	$(GEOMETRY_DIR)geometry.h\

#rules

all : $(NAME)

norm :
	norminette $(SRCS) $(HEADERS) $(addprefix $(SRCS_BONUS_DIR),$(SRCS_BONUS_NAME))

$(NAME) : $(OBJS) library
	$(CC) $(FLAG) -o $(NAME) $(OBJS) \
	-lm -L. -lft -I./includes -I./usr/include -lmlx -lpthread \
	-framework OpenGL -framework AppKit && ./$(NAME) map2.cub

bonus : $(OBJS_BONUS) library
	$(CC) $(FLAG) -o $(NAME) $(OBJS_BONUS) \
	-lm -L. -lft -I./includes -I./usr/include -lmlx \
	-framework OpenGL -framework AppKit && ./$(NAME) map_bonus.cub

linux: $(OBJS) library
	$(CC) $(FLAG) -o $(NAME) $(OBJS) \
	-lm -L. -lft \
	&& ./$(NAME) map.cub

%.o : %.c
	$(CC) $(FLAG) -c $*.c -o $@

lib : library

library : $(LIBFT)

$(LIBFT) :
	make -C $(LIBFT_DIR)
	mv $(LIBFT_DIR)$(LIBFT) .

clean :
	rm -rf $(SRCS_COMMON_DIR)*.o
	rm -rf $(SRCS_BONUS_DIR)*.o
	rm -rf $(SCREEN_DIR)*.o
	rm -rf $(LINEAR_DIR)*.o
	rm -rf $(BITMAP_DIR)*.o
	rm -rf $(GEOMETRY_DIR)*.o
	make clean -C $(LIBFT_DIR)

fclean : clean
	make fclean -C $(LIBFT_DIR)
	rm -rf $(NAME)
	rm -rf $(LIBFT)

re : fclean $(NAME)

reb : fclean bonus

# MMS_DIR = ./minilibx_mms_20200219/
# MMS = libmlx.dylib

# OPENGL_DIR = ./minilibx_opengl_20191021/
# OPENGL = libmlx.a

# mms :
# 	make -C $(MMS_DIR)
# 	mv $(MMS_DIR)$(MMS) ./$(MMS)

# opengl :
# 	make -C $(OPENGL_DIR)
# 	mv $(OPENGL_DIR)$(OPENGL) ./$(OPENGL)

# clean :
# 	rm -rf $(OBJS) $(LIBFT) $(MMS) $(OPENGL)
# 	make clean -C $(LIBFT_DIR)
# 	make clean -C $(MMS_DIR)
# 	make clean -C $(OPENGL_DIR)

# fclean :
# 	rm -rf $(OBJS) $(LIBFT) $(MMS) $(OPENGL) $(NAME)
# 	make clean -C $(LIBFT_DIR)
# 	make clean -C $(MMS_DIR)
# 	make clean -C $(OPENGL_DIR)

# re : fclean $(NAME)
