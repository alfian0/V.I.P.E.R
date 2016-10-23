# Basic API for a demo to-do list app

Allows you to create, view, update and delete todo list items.

## Registration
All endpoints that deal with todo CRUD expect the authorisation header in the request along with the token. The format of the header should be: `Authorization: Bearer <Your token>`

To get a token, you must first register as a user:

>		POST /register

### Parameters:
-	`username`: A valid email address
-	`password`: A password of your choice

### Sample response
>		{
>			"error": null,
>			"data": {
>				"user": {
>					"_id": "fiodjsf01903uj",
>					"todos": []
>				},
>				"token": "32910i392.9903i092i193i902i193i.3i201i039i12"
>			}
>		}

## Login
The login call is to be used to get the auth token.

>		POST /login

### Parameters:
-	`username`: A valid email address
-	`password`: A password of your choice

### Sample Response
>		{
>			"error": null,
>			"data": {
>				"user": {
>					"_id": "fiodjsf01903uj",
>					"todos": []
>				},
>				"token": "32910i392.9903i092i193i902i193i.3i201i039i12"
>			}
>		}

## Getting Todos

>		GET /todos

### Sample Response
>		{
>			error: null,
>			data: [
>				{ "_id": "43i9204i390jfdfj", "description": "Buy milk", "userID": "fod209fl" },
>				{ "_id": "43i9fid0fdfj", "description": "Pay bills", "userID": "fod209fl" }
>			]
>		}

## Create Todos

>		POST /todos/create

### Parameters:
-		`description`: The description of the todo item

### Sample Response

>		{
>			"error": null,
>			"data": { "_id": "43i9204i390jfdfj", "description": "Buy milk", "userID": "fod209fl" }
>		}

## Update Todo
>		PATCH /todos/:todoID

### Parameters
-		`description`: The udpdated description of the todo item

### Sample Response
>		{
>			"error": null,
>			"data": { "_id": "43i9204i390jfdfj", "description": "Buy milk", "userID": "fod209fl" }
>		}

## Delete Todo

>		DELETE /todos/:todoID

### Sample Response
>		{
>			"error": null,
>			"data": {
>				"message": "Deleted"
>			}
>		}
