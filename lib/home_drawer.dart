import 'package:flutter/material.dart';

import 'helpers/custom_color.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.PRIMARY_LIGHT,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new DrawerHeader(
                child: Center(
                    child: Text("Gclone app",
                        style: TextStyle(
                            color: AppColors.LIGHT_TEXT,
                            letterSpacing: 1,
                            fontSize: 30))),
                decoration: BoxDecoration(
                    color: AppColors.SECONDARY,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(30)))),
            ListTile(
              leading: new Icon(
                Icons.import_export,
                color: Color(0xFF999B9B),
              ),
              subtitle: Text(
                "Importar faxinas",
                style: TextStyle(
                    color: Color(0xFF999B9B), fontStyle: FontStyle.italic),
              ),
              title: Text(
                "Importar",
                style: TextStyle(color: Color(0xFF999B9B), fontSize: 20),
              ),
              onTap: () async {
//                  CleaningBloc _bloc = BlocProvider.of(context);
//
//                  var _provider =
//                      BlocProvider(bloc: _bloc, child: ImportPage());
//
//                  await Navigator.push(
//                    context,
//                    AnimateRoute<bool>(builder: (context) => _provider),
//                  );
//
//                  Navigator.pop(context);
              },
            ),
            ListTile(
              leading: new Icon(
                Icons.sync,
                color: Color(0xFF999B9B),
              ),
              subtitle: Text(
                "Sincronizar faxinas compartilhadas",
                style: TextStyle(
                    color: Color(0xFF999B9B), fontStyle: FontStyle.italic),
              ),
              title: Text(
                "Sincronizar",
                style: TextStyle(color: Color(0xFF999B9B), fontSize: 20),
              ),
              onTap: () async {
//                  Navigator.pop(context);
//                  SharedUtil.syncronized(context);
              },
            ),
            Divider(color: AppColors.SECONDARY),
            ListTile(
              leading: new Icon(
                Icons.clear_all,
                color: Color(0xFF999B9B),
              ),
              subtitle: Text(
                "Gerenciar faxinas",
                style: TextStyle(
                    color: Color(0xFF999B9B), fontStyle: FontStyle.italic),
              ),
              title: Text(
                "Faxinas",
                style: TextStyle(color: Color(0xFF999B9B), fontSize: 20),
              ),
              onTap: () async {
//                  CleaningBloc _bloc = BlocProvider.of(context);
//
//                  var _provider =
//                      BlocProvider(bloc: _bloc, child: CleaningWidget());
//
//                  await Navigator.push(
//                    context,
//                    AnimateRoute<bool>(builder: (context) => _provider),
//                  );
//
//                  //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: new Icon(
                Icons.fitness_center,
                color: Color(0xFF999B9B),
              ),
              subtitle: Text(
                "Gerenciar tarefas",
                style: TextStyle(
                    color: Color(0xFF999B9B), fontStyle: FontStyle.italic),
              ),
              title: Text(
                "Tarefas",
                style: TextStyle(color: Color(0xFF999B9B), fontSize: 20),
              ),
              onTap: () async {
//                  var bloc = BlocProvider(
//                    bloc: TaskBloc(),
//                    child: TaskWidget(),
//                  );
//
//                  await Navigator.push(
//                    context,
//                    AnimateRoute<bool>(builder: (context) => bloc),
//                  );
//
//                  //Navigator.pop(context);
              },
            ),
            ListTile(
              leading: new Icon(
                Icons.shopping_cart,
                color: Color(0xFF999B9B),
              ),
              subtitle: Text(
                "Gerenciar produtos",
                style: TextStyle(
                    color: Color(0xFF999B9B), fontStyle: FontStyle.italic),
              ),
              title: Text(
                "Produtos",
                style: TextStyle(color: Color(0xFF999B9B), fontSize: 20),
              ),
              onTap: () async {
//                  var bloc = BlocProvider(
//                    bloc: ProductBloc(),
//                    child: ProductWidget(),
//                  );
//
//                  await Navigator.push(
//                    context,
//                    AnimateRoute<bool>(builder: (context) => bloc),
//                  );
//
//                  //Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
