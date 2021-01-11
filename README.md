# F.D.Matlab

This project enumerates connected Feynmann Diagrams (CFD) of a real scalar field: 
L = [free.field.] + \sum_{n=1}^{N} g_n * phi^n / n!

* fun_EnumerateCFD.m
Enumerates the C-matrices of all the topologically different CFD with Num_E distinct external points and Num_Vn internal order-n vertices, along with their symmetry factors. 

* fun_Cmat2CFD.m
Re-express each C-matrix in terms of edges, in order for a convenient plotting with Matlab's graph() function. 
