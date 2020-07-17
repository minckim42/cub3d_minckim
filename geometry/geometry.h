/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   geometry.h                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: minckim <minckim@student.42seoul.kr>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/07/14 00:07:08 by minckim           #+#    #+#             */
/*   Updated: 2020/07/16 10:01:10 by minckim          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef GEOMETRY_H
# define GEOMETRY_H
# define TRIANGLE 0
# define RECTANGLE 1
# include "../linear_algebra/linear_algebra.h"
# define DEF_COLOR 0x00ff0000

/*
** face type:
**	0 : triangle
**	1 : rectangle
*/
typedef struct		s_face{
	int				type;
	int				color;
	void			*img;
	t_vec			a;
	t_vec			b;
	t_vec			c;
	t_vec			u;
	t_vec			v;
	t_vec			n;
}					t_face;

typedef struct		s_entity{
	int				type;
	int				n_face;
	t_vec			origin;
	t_real			h;
	t_real			v;
	t_face			*face;
}					t_entity;

/*
** ============================================================================
** face.c
** ============================================================================
*/
t_face				face_new(t_vec *a, t_vec *b, t_vec *c, int color);
t_face				face_copy(t_face *f, t_vec *v);
t_face				*face_move(t_face *f, t_vec *v);
t_face				*face_rot(t_face *f, t_vec *center, t_real h, t_real v);
t_face				*face_rot_rc(t_face *f, t_vec *center, t_real h, t_real v);
/*
** ============================================================================
** entity.c
** ============================================================================
*/
t_entity			entity_new(t_face *face, int n);
t_entity			*entity_move(t_entity *e, t_vec *v);
t_entity			*entity_rot(t_entity *e, t_real h, t_real v);
t_entity			entity_deepcopy(t_entity *e, t_vec *v);
t_entity			entity_copy(t_entity *e, t_vec *v);
/*
** ============================================================================
** entity.c
** ============================================================================
*/
void				face_print(t_face *f);
#endif
