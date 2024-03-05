abstract class TasksState{}
 class TasksInitialState extends TasksState{}
class InsertedDatabaseState extends TasksState{}
class InsertedErrorDatabaseState extends TasksState{}
class LoadingUpdateDatabaseState extends TasksState{}
class SuccessUpdateDatabaseState extends TasksState{}
class ErrorUpdateDatabaseState extends TasksState{}

class LoadingGetDatabaseState extends TasksState{}
class SuccessGetDatabaseState extends TasksState{}
class ErrorGetDatabaseState extends TasksState{}

class ChangeNavBarState extends TasksState{}