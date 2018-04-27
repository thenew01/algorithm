// qsort.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <WTypes.h>
#include <winbase.h>
/*
 *author: booirror@163.com
 *date: 2015/4/28
 */
#include <stdio.h>

#include <stack>
#include "AStar.h"

int ra[10] = {12, 23, 55, 33, 1, 25, 32, 99, 77, 11};
int ar[6] = {4, 22, 11, 77, 33, 41};

void swap(int a[], int n, int m)
{
	if (n == m) return;
	int tmp = a[n];
	a[n] = a[m];
	a[m] = tmp;
}
//没有二分，哪里是quick sort了？
void qsort(int a[], int n)
{
	int i, j;
	int last = 0;
	if (n < 2) return;
	swap(a, 0, n/2);
	for (i = 1; i < n; i++) {
		if (a[i] < a[0]) {
			swap(a, ++last, i);
		}
	}
	swap(a, 0, last);
	qsort(a, last);
	qsort(a+last+1, n-last-1);
}


int a[10], book[10], n = 9, total = 0;
void deepFirstSearch(int step)
{
	int i;
	if( step == n+1 )
	{
		if( a[1] * 100 + a[2] * 10 + a[3] + 
			a[4] * 100 + a[5] * 10 + a[6] == 
			a[7] * 100 + a[8] * 10 + a[9] )
		{
			total++;
			printf("%d%d%d+%d%d%d=%d%d%d\n", a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9] );
		}
		return;
	}

	for ( i = 1;i <= n; i++) //没有用0号索引
	{
		if( book[i] ==0 )
		{
			a[step] = i;
			book[i] = 1;
			deepFirstSearch(step+1);
			book[i] = 0;
		}
	}

	return;
}

int main()
{
	int i = 0;
    
   /* qsort(ra, 10);

    while (i < 10)
        printf(" %d", ra[i++]);
    puts("\n");
   
	qsort(ar, 6);
	for (i=0; i < 6; i++) {
		printf("%d ", ar[i]);
	}*/

	deepFirstSearch(1);
	printf("total:%d", total/2);
	puts("\n");


	
	// A*搜索 [4/12/2018 wei]	
	/*
	* 第一个问题：起点FGH需要初始化吗？
	* 看参考资料的图片发现不需要
	*/
	DWORD dwBegin = GetTickCount();

	PointEx start(1, 1);
	PointEx end(160, 51);
	stack<PointEx*>* stack = AStarPathFind::printPath(start, end);
	if(NULL==stack) 
	{
		printf("不可达");
	}else 
	{
		while(!stack->empty())
		{
			//输出(1,2)这样的形势需要重写toString
			PointEx* pt = stack->top();
			stack->pop();			
			printf("(%d,%d)->", pt->x, pt->y);
			delete pt;
		}
	}

	printf("\n\ntime:%dMS", GetTickCount() - dwBegin);
	

	getchar();
	

    return 0;
}