#include <GL/glut.h>    
#include <stdio.h>    
#include <Windows.h>    
#include <stdlib.h>    
#include <math.h>

GLfloat UniformPoints[4][4][3] =
{
	{
		{ -1.0f, -0.4f, 0.5f }, { -0.4f, -0.8f, 0.2f }, { 0.2f, -0.65f, 0.3f }, { 0.7f, -0.7f, 0.2f }
	},
	{
		{ -0.9f, -0.2f, 0.3f }, { -0.3f, -0.4f, 0.2f }, { 0.3f, -0.2f, 0.4f },	{ 0.75f, -0.2f, 0.3f },
	},
	{
		{ -0.9f, 0.3f, 0.3f }, { -0.3f, 0.2f, 0.5f }, { 0.25f, 0.25f, 0.6f },	{ 0.8f, 0.3f, 0.3f },
	},
	{
		{ -0.8f, 0.8f, 0.1f }, { -0.2f, 0.8f, 0.2f }, { 0.2f, 0.85f, 0.1f },	{ 0.7f, 0.8f, 0.1f },
	}
};



void Bezierrr(void)
{

	glClear(GL_COLOR_BUFFER_BIT);
	GLfloat calculate1[11][4][3];//先一个方向求bezier曲线，再求另一个方向
	for (int j = 0; j < 4; j++) {
		GLint i = 0;
		for (double t = 0.0; t <= 1.0; t += 0.1)
		{

			double a1 = pow((1 - t), 3);
			double a2 = pow((1 - t), 2) * 3 * t;
			double a3 = 3 * t*t*(1 - t);
			double a4 = pow(t, 3);//三次Bezier的系数
			calculate1[i][j][0] = a1 * UniformPoints[0][j][0] + a2 * UniformPoints[1][j][0] + a3 * UniformPoints[2][j][0] + a4 * UniformPoints[3][j][0];
			calculate1[i][j][1] = a1 * UniformPoints[0][j][1] + a2 * UniformPoints[1][j][1] + a3 * UniformPoints[2][j][1] + a4 * UniformPoints[3][j][1];
			calculate1[i][j][2] = a1 * UniformPoints[0][j][2] + a2 * UniformPoints[1][j][2] + a3 * UniformPoints[2][j][2] + a4 * UniformPoints[3][j][2];
			i = i + 1;
		}
	}


	GLfloat calculate2[11][11][3];
	for (int j = 0; j < 11; j++) {
		GLint i = 0;
		for (double t = 0.0; t <= 1.0; t += 0.1)
		{
			double a1 = pow((1 - t), 3);
			double a2 = pow((1 - t), 2) * 3 * t;
			double a3 = 3 * t*t*(1 - t);
			double a4 = pow(t, 3);
			calculate2[j][i][0] = a1 * calculate1[j][0][0] + a2 * calculate1[j][1][0] + a3 * calculate1[j][2][0] + a4 * calculate1[j][3][0];
			calculate2[j][i][1] = a1 * calculate1[j][0][1] + a2 * calculate1[j][1][1] + a3 * calculate1[j][2][1] + a4 * calculate1[j][3][1];
			calculate2[j][i][2] = a1 * calculate1[j][0][2] + a2 * calculate1[j][1][2] + a3 * calculate1[j][2][2] + a4 * calculate1[j][3][2];
			i = i + 1;
		}
	}


	glColor3f(1.0, 1.0, 1.0);
	for (int i = 0; i < 11; i++) {
		glBegin(GL_LINE_STRIP);
		for (int j = 0; j < 11; j++)
			glVertex3fv(&calculate2[i][j][0]);
		glEnd();

		glBegin(GL_LINE_STRIP);
		for (int j = 0; j < 11; j++)
			glVertex3fv(&calculate2[j][i][0]);
		glEnd();
	}


	glPointSize(5.0);
	glColor3f(1.0, 0.0, 0.0);

	for (int i = 0; i < 4; i++) {
		glBegin(GL_POINTS);
		for (int j = 0; j < 4; j++)
			glVertex3fv(&UniformPoints[i][j][0]);
		glEnd();
	}//绘制点


	glColor3f(1.0, 1.0, 0.0);
	for (int i = 0; i < 4; i++) {
		glBegin(GL_LINE_STRIP);
		for (int j = 0; j < 4; j++)
			glVertex3fv(&UniformPoints[i][j][0]);
		glEnd();
		glBegin(GL_LINE_STRIP);
		for (int j = 0; j < 4; j++)
			glVertex3fv(&UniformPoints[j][i][0]);
		glEnd();
	}//连线

	glFlush();
}

void B_Spline(void)
{

	glClear(GL_COLOR_BUFFER_BIT);


	GLfloat calculate1[11][4][3];//先一个方向求B样条曲线，再求另一个方向
	for (int j = 0; j < 4; j++) {
		GLint i = 0;
		for (double t = 0.0; t <= 1.0; t += 0.1)
		{
			double a1 = (pow((1 - t), 3)) / 6;
			double a2 = (3 * pow(t, 3) - 6 * pow(t, 2) + 4) / 6;
			double a3 = (3 * (pow(t, 2) + t - pow(t, 3)) + 1) / 6;
			double a4 = (pow(t, 3)) / 6;//三次B样条的系数
			calculate1[i][j][0] = a1 * UniformPoints[0][j][0] + a2 * UniformPoints[1][j][0] + a3 * UniformPoints[2][j][0] + a4 * UniformPoints[3][j][0];
			calculate1[i][j][1] = a1 * UniformPoints[0][j][1] + a2 * UniformPoints[1][j][1] + a3 * UniformPoints[2][j][1] + a4 * UniformPoints[3][j][1];
			calculate1[i][j][2] = a1 * UniformPoints[0][j][2] + a2 * UniformPoints[1][j][2] + a3 * UniformPoints[2][j][2] + a4 * UniformPoints[3][j][2];
			i = i + 1;
		}
	}


	GLfloat calculate2[11][11][3];
	for (int j = 0; j < 11; j++) {
		GLint i = 0;
		for (double t = 0.0; t <= 1.0; t += 0.1)
		{
			double a1 = (pow((1 - t), 3)) / 6;
			double a2 = (3 * pow(t, 3) - 6 * pow(t, 2) + 4) / 6;
			double a3 = (3 * (pow(t, 2) + t - pow(t, 3)) + 1) / 6;
			double a4 = (pow(t, 3)) / 6;
			calculate2[j][i][0] = a1 * calculate1[j][0][0] + a2 * calculate1[j][1][0] + a3 * calculate1[j][2][0] + a4 * calculate1[j][3][0];
			calculate2[j][i][1] = a1 * calculate1[j][0][1] + a2 * calculate1[j][1][1] + a3 * calculate1[j][2][1] + a4 * calculate1[j][3][1];
			calculate2[j][i][2] = a1 * calculate1[j][0][2] + a2 * calculate1[j][1][2] + a3 * calculate1[j][2][2] + a4 * calculate1[j][3][2];
			i = i + 1;
		}
	}


	glColor3f(1.0, 1.0, 1.0);
	for (int i = 0; i < 11; i++) {
		glBegin(GL_LINE_STRIP);
		for (int j = 0; j < 11; j++)
			glVertex3fv(&calculate2[i][j][0]);
		glEnd();

		glBegin(GL_LINE_STRIP);
		for (int j = 0; j < 11; j++)
			glVertex3fv(&calculate2[j][i][0]);
		glEnd();
	}


	glPointSize(5.0);
	glColor3f(1.0, 0.0, 0.0);

	for (int i = 0; i < 4; i++) {
		glBegin(GL_POINTS);
		for (int j = 0; j < 4; j++)
			glVertex3fv(&UniformPoints[i][j][0]);
		glEnd();
	}//绘制点


	glColor3f(1.0, 1.0, 0.0);
	for (int i = 0; i < 4; i++) {
		glBegin(GL_LINE_STRIP);
		for (int j = 0; j < 4; j++)
			glVertex3fv(&UniformPoints[i][j][0]);
		glEnd();
		glBegin(GL_LINE_STRIP);
		for (int j = 0; j < 4; j++)
			glVertex3fv(&UniformPoints[j][i][0]);
		glEnd();
	}//连线

	glFlush();
}


int main(int argc, char** argv)
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGB | GLUT_SINGLE);
	glutInitWindowPosition(100, 100);
	glutInitWindowSize(400, 400);
	
	int i;
	printf("\n Bezier(1) or B Spline(2)\n");
	scanf_s("%d", &i);
	switch (i) 
	{
	case 1:
		glutCreateWindow("Asgmt2_11619370216_Bezier_Surface");
		glutDisplayFunc(Bezierrr);
		break;
	case 2:
		glutCreateWindow("Asgmt2_11619370216_B_Spline_Surface");
		glutDisplayFunc(B_Spline);
		break;
	default:
		printf("\n Error!!\n");
	}
	
	glutMainLoop();
	return 0;
}