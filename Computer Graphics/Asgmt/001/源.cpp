
#include<GL/glut.h>
#include<iostream>
#include <stdio.h>
#include<math.h>

using namespace std;

void set_mid(int x, int y) //将用中点画线法的图用蓝色线表示
{
	glColor3f(0.0, 0.0, 1.0);
	glPointSize(2.0f);
	glBegin(GL_POINTS);
	glVertex2i(x, y);
	glEnd();
	glFlush();
}

void set_bre(int x, int y) //将用Bresenham画线法的图用绿色线表示
{
	glColor3f(0.0, 1.0, 0.0);
	glPointSize(2.0f);
	glBegin(GL_POINTS);
	glVertex2i(x, y);
	glEnd();
	glFlush();
}
/*中点画直线*/
void MidpointLine(int x0, int y0, int x1, int y1)
{
	/*
	用2d代替d的中点画线法的算法步骤（0≤k≤1 ）
	1. 输入直线段的两个端点P1(x1, y1)和P2(x2, y2)。
	2. 初始化：a，b，d=2a+b，x=x1，y=y1，画点(x, y)。
	3. 若x<x2，则执行下列各步，否则算法结束。
	4. 判断d的符号：若d<0，则(x, y)更新为(x+1, y+1)，d更新为d+2a+2b；否则(x, y)更新为(x+1, y)，d更新为d+2a。
	5. 画点(x, y)，返回3。
	*/
	if ((x0 != x1) && (y0 != y1))
	{
		int a, b, deltal, delta2, d, x, y;
		a = y0 - y1;
		b = x1 - x0;
		d = 2 * a + b;
		deltal = 2 * a;
		delta2 = 2 * (a + b);
		x = x0;
		y = y0;
		set_mid(x, y);
		while (x < x1)
		{
			if (d < 0)
			{
				x++;
				y++;
				d += delta2;//when d<0, y=y+1
			}
			else
			{
				x++;
				d += deltal;//when d>=0, y=y
			}
			set_mid(x, y);
		}
	}
	else
	{
		int d;
		if (x0 == x1)
		{
			int x = x0, y;
			y = (y0 <= y1) ? y0 : y1;
			d = fabs((double)(y0 - y1));
			while (d <= 0)
			{
				set_mid(x, y);
				y++;
				d--;
			}
		}
	}
}

/*中点画圆*/
void MidpointCircle(int x0, int y0, int r) //（x0, y0）为圆心坐标， r为半径
{
	int x = x0, y = y0 + r, d, deltax, deltay;
	deltax = 3;
	deltay = 2 - r - r;
	d = 1 - r;
	set_mid(x, y);
	while (x < y)
	{
		if (d < 0)
		{
			d += deltax;
			deltax += 2;
			x++;
		}
		else
		{
			d += (deltax + deltay);
			deltax += 2;
			deltay += 2;
			x++;
			y--;
		}
		set_mid(x, y);
		set_mid(y, x);
		set_mid(x, y0 + y0 - y);
		set_mid(y0 + y0 - y, x);
		set_mid(x0 + x0 - x, y);
		set_mid(y, x0 + x0 - x);
		set_mid(x0 + x0 - x, y0 + y0 - y);
		set_mid(y0 + y0 - y, x0 + x0 - x);
	}

}

/*中点画椭圆*/
//上部区域生成算法的循环终止条件是：2b2(x + 1) >= 2a2(y – 0.5)，下部区域的循环终止条件是y = 0，
void MidpointEllipse(int x0, int y0, int a, int b)
{
	double sqa = a * a;
	double sqb = b * b;

	double d = sqb + sqa * (0.25 - b);
	int x = 0;
	int y = b;
	// 1
	set_mid((x0 + x), (y0 + y));
	// 2
	set_mid((x0 + x), (y0 - y));
	// 3
	set_mid((x0 - x), (y0 - y));
	// 4
	set_mid((x0 - x), (y0 + y));
	while (sqb*(x + 1) < sqa*(y - 0.5))
	{
		if (d < 0)
		{
			d += sqb * (2 * x + 3);
		}
		else
		{
			d += (sqb*(2 * x + 3) + sqa * ((-2)*y + 2));
			--y;
		}
		++x;
		// 1
		set_mid((x0 + x), (y0 + y));
		// 2
		set_mid((x0 + x), (y0 - y));
		// 3
		set_mid((x0 - x), (y0 - y));
		// 4
		set_mid((x0 - x), (y0 + y));
	}
	d = (b * (x + 0.5)) * 2 + (a * (y - 1)) * 2 - (a * b) * 2;
	// 2
	while (y > 0)
	{
		if (d < 0)
		{
			d += sqb * (2 * x + 2) + sqa * ((-2) * y + 3);
			++x;
		}
		else
		{
			d += sqa * ((-2) * y + 3);
		}
		--y;
		// 1
		set_mid((x0 + x), (y0 + y));
		// 2
		set_mid((x0 + x), (y0 - y));
		// 3
		set_mid((x0 - x), (y0 - y));
		// 4
		set_mid((x0 - x), (y0 + y));
	}
}

/*Bresenham画直线*/
void BresenhamLine(int x1, int y1, int x2, int y2)
{
	int dx, dy, sx, sy, x, y, a;
	dx = x2 - x1;
	dy = y2 - y1;
	sx = (dx >= 0) ? 1 : (-1);
	sy = (dy >= 0) ? 1 : (-1);
	x = x1;
	y = y1;
	a = 0;

	if (abs(dy) > abs(dx))
	{
		float tdx = dx;
		dx = dy;
		dy = tdx;

		a = 1;
	}

	float p = 2 * (abs(dy)) - abs(dx);

	set_bre(x, y);

	for (int i = 0; i <= abs(dx);i++)
	{
		if (p < 0)
		{
			if (a == 0) {
				x = x + sx;
				set_bre(x, y);
			}
			else {
				y = y + sy;
				set_bre(x, y);
			}
			p = p + 2 * abs(dy);
		}
		else
		{
			x = x + sx;
			y = y + sy;
			set_bre(x, y);
			p = p + 2 * abs(dy) - 2 * abs(dx);
		}
	}
}

/*Bresenham画圆*/
void BresenhamCircle(int cx, int cy, int r)
{
	int x = 0, y = r;
	int d = 1 - r;

	set_bre(cx, cy);

	while (x <= y)
	{
		set_bre(cx + x, cy + y);
		set_bre(cx - x, cy + y);
		set_bre(cx + x, cy - y);
		set_bre(cx - x, cy - y);
		set_bre(cx + y, cy + x);
		set_bre(cx - y, cy + x);
		set_bre(cx + y, cy - x);
		set_bre(cx - y, cy - x);
		if (d <= 0) {
			d += (x << 1) + 3;
		}
		else {
			d += ((x - y) << 1) + 5;
			y--;
		}
		x++;
	}
}

/*Bresenham画椭圆*/
void BresenhamEllipse(int x0, int y0, int a, int b)
{
	int x, y;
	float d1, d2, aa, bb;
	aa = a * a;
	bb = b * b;
	d1 = bb + aa * (-b + 0.25);
	glTranslatef((GLfloat)x0, (GLfloat)y0, 0.0f);
	x = 0;
	y = b;
	set_bre(x, y);
	set_bre(-x, y);
	set_bre(-x, -y);
	set_bre(x, -y);
	while (bb * (x + 1) < aa * (y - 0.5))
	{
		if (d1 <= -0.000001)
		{
			d1 += bb * ((x << 1) + 3);

		}
		else
		{
			d1 += bb * ((x << 1) + 3) + aa * (2 - (y << 1));
			--y;
		}
		++x;
		set_bre(x, y);
		set_bre(-x, y);
		set_bre(-x, -y);
		set_bre(x, -y);
	}
	d2 = bb * (0.25 * x) + aa * (1 - (y << 1));
	while (y > 0)
	{
		if (d2 <= -0.000001)
		{
			++x;
			d2 += bb * ((x + 1) << 1) + aa * (3 - (y << 1));
		}
		else
		{
			d2 += aa * (3 - (y << 1));
		}
		--y;
		set_bre(x, y);
		set_bre(-x, -y);
		set_bre(-x, y);
		set_bre(x, -y);
	}
}


void Display()
{
	glClear(GL_COLOR_BUFFER_BIT);

	MidpointLine(0, 0, 400, 100);//Midpoint直线
	MidpointCircle(0, 0, 200);//Midpoint圆
	MidpointEllipse(0, 0, 200, 100);//Mid椭圆
	BresenhamLine(0, 0, 100, 400);//Bresenham直线
	BresenhamCircle(0, 0, 300);//Bresenham圆
	BresenhamEllipse(0, 0, 300, 200);//Bresenham圆

	glEnd();
	glFlush();
}

int main(int argc, char ** argv)
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
	glutInitWindowPosition(300, 100);
	glutInitWindowSize(500, 500);
	glutCreateWindow("Asgmt1_11619370216");
	glClearColor(1.0, 1.0, 1.0, 0.0);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluOrtho2D(-500.0, 500.0, -500.0, 500.0);//坐标轴范围：横坐标（-500，500），纵坐标（-500，500）
	glutDisplayFunc(Display);
	glutMainLoop();
	return 0;
}