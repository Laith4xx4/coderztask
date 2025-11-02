// All widgets for demo purposes ------->
// BlocConsumer------->/* BlocConsumer(listener: (context, state) {if (state is MyState) {print(state.message);}}, builder: (context, state) {return Center(child: Text(state.message));}) */ // يستخدم للاستماع إلى تغييرات الحالة وإعادة بناء الواجهة بناءً عليها.
// listener------->/* listener: (context, state) {if (state is MyState) {print(state.message);}} */ // جزء من BlocConsumer يستمع للتغييرات ولا يعيد بناء الواجهة.
// builder------->/* builder: (context, state) {return Center(child: Text(state.message));} */ // جزء من BlocConsumer يعيد بناء الواجهة عند تغيير الحالة.
// trailing------->/* trailing: Icon(Icons.arrow_back) */ // يستخدم لوضع ويدجت في نهاية ListTile أو أشرطة التطبيق.
// mainAxisSize: MainAxisSize.min,------->/* mainAxisSize: MainAxisSize.min, */ // يجعل العمود أو الصف يأخذ أقل مساحة ممكنة.
// showDatePicker------->/* showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now()) */ // لعرض منتقي التاريخ لاختيار تاريخ.
// validator------->/* validator: (value) {if (value == null || value.isEmpty) {return 'Please enter your name';} return null;}) */ // للتحقق من صحة إدخال المستخدم في حقول النموذج.
// DropdownButtonFormField------->/* DropdownButtonFormField(items: [DropdownMenuItem(value: '1', child: Text('1')), DropdownMenuItem(value: '2', child: Text('2'))], onChanged: (value) {print(value);}) */ // لإنشاء حقل تحديد من قائمة منسدلة.
// Text------->/* Text('Hello') */ // لعرض نص بسيط.
// Container------->/* Container(color: Colors.red, child: Text('Hello')) */ // لتجميع وتزيين الويدجت الأخرى.
// Column------->/* Center(child: Column(children: [Text('Hello'), Text('World')])) */ // لترتيب الويدجت عمودياً.
// Row------->/* Center(child: Row(children: [Text('Hello'), Text('World')])) */ // لترتيب الويدجت أفقياً.
// Scaffold------->/* Scaffold(appBar: AppBar(title: Text('My App')), body: Center(child: Column(children: [Text('Hello'), Text('World')])))) */ // يوفر بنية أساسية لتطبيق Flutter (شريط التطبيق، الجسم، إلخ).
// AppBar------->/* AppBar(title: Text('My App')) */ // شريط التطبيق العلوي.
// ElevatedButton-------> /* ElevatedButton(onPressed: () {print('Hello');}, child: Text('Click me')) */ // زر مرتفع يمكن النقر عليه.
// TextButton-------> /* TextButton(onPressed: () {print('Hello');}, child: Text('Click me')) */ // زر نصي يمكن النقر عليه.
// ListTile-------> /* ListTile(title: Text('Hello'), subtitle: Text('World')) */ // ويدجت لتنظيم المحتوى في قائمة.
// DropdownButtonFormField-------> /* DropdownButtonFormField(items: [DropdownMenuItem(value: '1', child: Text('1')), DropdownMenuItem(value: '2', child: Text('2'))], onChanged: (value) {print(value);}) */ // لإنشاء حقل تحديد من قائمة منسدلة مع التحقق من الصحة.
// TextFormField-------> /* TextFormField(decoration: InputDecoration(labelText: 'Enter your name'), validator: (value) {if (value == null || value.isEmpty) {return 'Please enter your name';} return null;}) */ // حقل إدخال نص مع إمكانية التحقق من الصحة.
// BlocConsumer-------> /* BlocConsumer(listener: (context, state) {if (state is MyState) {print(state.message);}}, builder: (context, state) {return Center(child: Text(state.message));}) */ // يستمع للتغييرات ويعيد بناء الواجهة.
// MultiBlocProvider-------> // لتوفير عدة Bloc's لأشجار الويدجت الفرعية.
// BlocProvider-------> /* BlocProvider(create: (context) => MyBloc(), child: MyWidget()) */ // لتوفير Bloc واحد لأشجار الويدجت الفرعية.
// MaterialApp-------> /* MaterialApp(home: MyWidget()) */  // التطبيق الأساسي في Flutter الذي يوفر تصميم Material Design.
// ThemeData-------> /* ThemeData(primarySwatch: Colors.blue) */ // لتحديد سمات التصميم للتطبيق.
// SnackBar-------> // لعرض رسالة مؤقتة في الجزء السفلي من الشاشة.
// Center-------> /* Center(child: Text('Hello')) */ // لتوسيط ويدجت داخل ويدجت أخرى.
// CircularProgressIndicator------->  // لعرض مؤشر تقدم دائري.
// TextField-------> /* TextField(decoration: InputDecoration(labelText: 'Enter your name'), validator: (value) {if (value == null || value.isEmpty) {return 'Please enter your name';} return null;}) */ // حقل إدخال نص.
// IconButton-------> /* IconButton(icon: Icon(Icons.add), onPressed: () {print('Hello');}) */ // زر أيقونة يمكن النقر عليه.
// Icon-------> /* Icon(Icons.add) */ // لعرض أيقونة.
// SizedBox-------> /* SizedBox(height: 10) */ // لإنشاء مسافة فارغة بحجم معين.
// Navigator-------> /* Navigator.push(context, MaterialPageRoute(builder: (context) => MyWidget())) */ // لإدارة مكدس الشاشات في التطبيق.
// MaterialPageRoute-------> /* MaterialPageRoute(builder: (context) => MyWidget()) */ // لإنشاء مسار جديد (شاشة) بتأثيرات Material Design.
// Card-------> /* Card(child: Text('Hello')) */ // لإنشاء بطاقة ذات تصميم مرتفع.
// CheckboxListTile-------> /* CheckboxListTile(value: true, onChanged: (value) {print(value);}) */ // ويدجت قائمة مع خانة اختيار.
// AlertDialog-------> /* AlertDialog(title: Text('My App'), content: Text('Hello'), actions: [TextButton(onPressed: () {print('Hello');}, child: Text('Click me'))]) */ // لعرض مربع حوار تنبيه.
// StatefulBuilder-------> /* StatefulBuilder(builder: (context, setState) {return Center(child: Text('Hello'));}) */ // لبناء ويدجت ذات حالة داخل ويدجت بدون حالة.
// SingleChildScrollView-------> /* SingleChildScrollView(child: Column(children: [Text('Hello'), Text('World')])) */ // لجعل المحتوى قابلاً للتمرير.
// Form-------> /* Form(child: Column(children: [Text('Hello'), Text('World')])) */ // لتجميع حقول النموذج مع إمكانية التحقق من الصحة.
// Padding-------> /* Padding(padding: EdgeInsets.all(10), child: Text('Hello')) */ // لإضافة مساحة حشو (Padding) حول ويدجت.
// BottomNavigationBar-------> /* BottomNavigationBar(items: [BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'), BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')]) */ // شريط التنقل السفلي.
// BottomNavigationBarItem-------> /* BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home') */   // عنصر في شريط التنقل السفلي.
// Packages used ------->
// flutter/material.dart:-------> يوفر عناصر واجهات المستخدم الأساسية لتطبيقات Flutter.
// flutter_bloc/flutter_bloc.dart:-------> يدعم نمط BLoC لإدارة الحالة بسهولة وفعالية.
// coderz1/bloc/auth/auth_bloc.dart:-------> يدير منطق وصلاحية المصادقة للمستخدمين.
// coderz1/screens/login_screen.dart:------->   تحتوي على واجهة تسجيل الدخول للمستخدم.
// coderz1/bloc/classroom_bloc/classroom_bloc.dart:-------> يدير حالات وإجراءات الفصول الدراسية.
// coderz1/bloc/student_bloc/student_bloc.dart:-------> يدير بيانات وحالات الطلاب.
// coderz1/bloc/task_assignment_bloc/task_assignment_bloc.dart:-------> يتحكم في منطق وإسناد المهام للطلاب أو الفصول.
// coderz1/bloc/attendance_bloc/attendance_bloc.dart:-------> يدير حضور الطلاب وتتبعه.
