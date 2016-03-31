//
//  Проект CheckList workshop 4/6
//
//  REST API для обращения на сервер 
//
//
//  Работа со справочниками (только чтение)
  {
	GET
			/Dictionaries/Persons		  - ответственные (Responsible)
			/Dictionaries/Places		  - места для заполнения (Places)
			/Dictionaries/Users		  - авторизуемые пользователи (Users)
  }
  
//  Работа с классификатором вопросов (только чтение). 
  {
	GET
			/Categories                   - список всех категорий (групп вопросов)
			/Categories/[cl_id]           - детали конкретной категории
			/Categories/Questions/[cl_id] - список вопросов из указанной категории
  }

//  Работа с анкетами (чтение)
  {
	GET
			/Checklists         - список всех анкет
			/Checklists/[cl_id] - список вопросов из указанной анкеты в порядке ввода
  }

//  Работа со списками заданий 
  {
	GET
			/Tasks                         - список всех заданий
			/Tasks/[tsk_id]                - содержание конкретного задания (не обязательно)
			/Tasks/OnDate/[user_id]/[date] - список всех заданий пользователя на дату
	POST
			/Tasks			  			   - запись всех заданий обратно на сервер
	PUT
			/Tasks/[tsk_id]                - модификация конкретной задачи (не обязательно)
	DELETE
			/Tasks/[tsk_id]                - удаление конкретной задачи (не обязательно)
  }

//  Работа с опросами (только передача и сохранение на сервере)
//  
  {
	GET 	/Surveys
	POST 	/Surveys

	GET 	/Surveys/Suresults
	POST 	/Surveys/Suresults/[tsk]

	GET 	/Surveys/Assignments
	POST 	/Surveys/Assignments/[tsk]
  }	
  