#include<iostream>
#include<malloc.h>
#include<stdio.h>

enum Status {
	ON, OFF, INPROCES
};

struct Document {
	int id;
	int nrPagini;
	char* numeDocument;
	Status status;
};

struct User {
	int id;
	char *nume;
};

struct NodLista {
	NodLista* prev;
	User info;
	NodLista* next;
};

struct Coada {
	NodLista* prim;
	NodLista* ultim;
};

Coada* InitiereCoada() {
	Coada* coada = (Coada*)malloc(sizeof(Coada));
	coada->prim = coada->ultim = NULL;

	return coada;
}

NodLista* CreareNod(User info) {
	NodLista* nod = (NodLista*)malloc(sizeof(NodLista));
	nod->info = info;
	nod->next = nod->prev = NULL;

	return nod;
}

void InserareNod(Coada*& coada, NodLista* nod) {
	if (coada->prim)
	{
		nod->next = coada->prim;
		coada->prim->prev = nod;
		coada->prim = nod;
	}
	else
	{
		coada->prim = coada->ultim = nod;
	}
}

User ExtragereNod(Coada*& coada) {
	User user;
	user.id = 0;
	user.nume = NULL;
	if (coada->ultim)
	{
		NodLista* p = coada->ultim;
		coada->ultim = coada->ultim->prev;
		coada->ultim->next = NULL;

		user.id = p->info.id;
		user.nume = (char*)malloc(sizeof(char)*(strlen(p->info.nume) + 1));
		strcpy(user.nume, p->info.nume);
		free(p->info.nume);
		free(p);
	}
	else
	{
		printf("\nNu exista elemente in coada");
	}

	return user;
}

void SteregereNod(Coada*& coada) {
	if (coada->ultim)
	{
		NodLista* p = coada->ultim;
		coada->ultim = coada->ultim->prev;
		if (coada->ultim)
			coada->ultim->next = NULL;
		else
			coada->prim = NULL;
		free(p->info.nume);
		free(p);
	}
	else
	{
		printf("\nNu exista elemente in coada");
	}
}

void SteregereCoada(Coada*& coada) {
	if (coada->ultim)
	{
		while (coada->ultim)
		{
			NodLista* p = coada->ultim;
			coada->ultim = coada->ultim->prev;
			if (coada->ultim)
			{
				coada->ultim->prev = NULL;
			}
			else
			{
				coada->prim = NULL;
			}
			free(p->info.nume);
			free(p);
		}
		printf("\nCoada a fost stearsa cu succes");
	}
	else
	{
		printf("\Nu exista elemente in coada");
	}
}

void AfisareCoada(Coada* coada) {
	if (coada->ultim)
	{
		NodLista* p = coada->ultim;
		while (p)
		{
			printf("\nId: %d Nume: %s", p->info.id, p->info.nume);
			p = p->prev;
		}
	}
	else
	{
		printf("\nNu exista elemente in coada");
	}

	printf("\n\n---------------\n");
}

Coada* CitesteCoada(char* fileName) {
	FILE* fin = fopen(fileName, "r");
	Coada* coada = InitiereCoada();
	NodLista* nod = NULL;
	User info;
	char buffer[255];

	if (fin)
	{
		while (!feof(fin))
		{
			fscanf(fin, "%d", &info.id);
			fscanf(fin, "%s", buffer);
			info.nume = (char*)malloc(sizeof(char)*(strlen(buffer) + 1));
			strcpy(info.nume, buffer);

			nod = CreareNod(info);
			InserareNod(coada, nod);
		}
	}
	else
	{
		printf("\nFisierul nu s-a deschis");
	}


	fclose(fin);

	return coada;
}


struct HashTable {
	int dimHT;
	NodLista** vector;
};

int functieHash(HashTable ht, int cod) {
	return cod%ht.dimHT;
}

HashTable InitializareHash(int dimHT) {
	HashTable ht;
	ht.dimHT = dimHT;
	ht.vector = (NodLista**)malloc(sizeof(NodLista*)*dimHT);
	for (int i = 0; i < dimHT; ++i)
		ht.vector[i] = NULL;

	return ht;
}


void InserareHash(HashTable ht, NodLista* nod) {
	int poz = functieHash(ht, nod->info.id);
	if (ht.vector[poz])
	{
		while (poz < ht.dimHT && ht.vector[poz] != NULL)
			poz++;
		if (poz == ht.dimHT)
		{
			poz = functieHash(ht, nod->info.id);
			while (poz >= 0 && ht.vector[poz] != NULL)
				poz--;
			if (poz < 0)
			{
				printf("\nNu s-a putut insera nodul in hash. Trebuie marita dimensiunea tabelei");
			}
			else
			{
				ht.vector[poz] = nod;
			}
		}
		else
		{
			ht.vector[poz] = nod;
		}
	}
	else
	{
		ht.vector[poz] = nod;
	}
}

HashTable CitireHash(char* fileName, int dimHT) {
	HashTable ht = InitializareHash(dimHT);
	NodLista* nod;
	User info;
	char buffer[255];

	FILE *fin = fopen(fileName, "r");
	if (fin)
	{
		while (!feof(fin))
		{
			fscanf(fin, "%d", &info.id);
			fscanf(fin, "%s", buffer);
			info.nume = (char*)malloc(sizeof(char)*(strlen(buffer) + 1));
			strcpy(info.nume, buffer);

			nod = CreareNod(info);
			InserareHash(ht, nod);
		}
		printf("\nTabela s-a creat cu succes");
	}
	else
	{
		printf("\nNu s-a deschis fisierul");
	}

	fclose(fin);
	return ht;
}

void AfisareHash(HashTable ht) {
	for (int i = 0; i < ht.dimHT; ++i)
	{
		if (ht.vector[i])
		{
			printf("\nPozitie: %d Id: %d Nume: %s", i, ht.vector[i]->info.id, ht.vector[i]->info.nume);
		}
	}
	printf("\n\n--------------\n");
}

User CautaDupaID(HashTable ht, int cod) {
	int poz = functieHash(ht, cod);
	User user;
	user.id = 0; 
	user.nume = NULL;
	if (ht.vector[poz]->info.id == cod)
	{
		user.id = ht.vector[poz]->info.id;
		user.nume = (char*)malloc(sizeof(char)*(strlen(ht.vector[poz]->info.nume) + 1));
		strcpy(user.nume, ht.vector[poz]->info.nume);

		return user;
	}
	else
	{
		while (poz < ht.dimHT && ht.vector[poz]->info.id != cod)
			poz++;
		if (poz == ht.dimHT)
		{
			poz = functieHash(ht, cod);
			while (poz >= 0 && ht.vector[poz]->info.id != cod)
				poz--;
			if (poz >= 0)
			{
				user.id = ht.vector[poz]->info.id;
				user.nume = (char*)malloc(sizeof(char)*(strlen(ht.vector[poz]->info.nume) + 1));
				strcpy(user.nume, ht.vector[poz]->info.nume);

				return user;
			}
			else
			{
				printf("\nNu exista element cu codul cautat");
			}
		}
		else
		{
			user.id = ht.vector[poz]->info.id;
			user.nume = (char*)malloc(sizeof(char)*(strlen(ht.vector[poz]->info.nume) + 1));
			strcpy(user.nume, ht.vector[poz]->info.nume);

			return user;
		}
	}

	return user;
}

void StergereDupaID(HashTable ht, int cod) {
	int poz = functieHash(ht, cod);

	if (ht.vector[poz]->info.id == cod)
	{
		free(ht.vector[poz]->info.nume);
		free(ht.vector[poz]);
		ht.vector[poz] = NULL;
	}
	else
	{
		while (poz < ht.dimHT && ht.vector[poz]->info.id != cod)
			poz++;
		if (poz == ht.dimHT)
		{
			poz = functieHash(ht, cod);
			while (poz >= 0 && ht.vector[poz]->info.id != cod)
				poz--;
			if (poz < 0)
			{
				printf("\nElementul cu codul dat nu exista");
			}
			else
			{
				free(ht.vector[poz]->info.nume);
				free(ht.vector[poz]);
				ht.vector[poz] = NULL;
			}
		}
		else
		{
			free(ht.vector[poz]->info.nume);
			free(ht.vector[poz]);
			ht.vector[poz] = NULL;
		}
	}
}

void stergereHash(HashTable ht) {
	for (int i = 0; i < ht.dimHT; ++i)
	{
		if (ht.vector[i])
		{
			free(ht.vector[i]->info.nume);
			free(ht.vector[i]);
			ht.vector[i] = NULL;
		}
	}
}


//Hash Table chaining
HashTable* initializareHashChaining(int dimHT) {
	HashTable* ht = (HashTable*)malloc(sizeof(HashTable));
	ht->vector = (NodLista**)malloc(sizeof(NodLista*)*dimHT);
	ht->dimHT = dimHT;
	for (int i = 0; i < dimHT; ++i)
	{
		ht->vector[i] = (NodLista*)malloc(sizeof(NodLista));
		ht->vector[i] = NULL;
	}
	return ht;
}

int functieHashChaining(HashTable* ht, int cod) {
	return cod%ht->dimHT;
}

void InserareNodLista(NodLista*& lista, NodLista* nod) {
	if (lista)
	{
		nod->next = lista;
		lista = nod;
	}
	else
	{
		lista = nod;
	}
}

void InserareNodHash(HashTable*& ht, NodLista* nod) {
	int poz = functieHashChaining(ht, nod->info.id);
	InserareNodLista(ht->vector[poz], nod);
}

void AfisareHash(HashTable* ht) {
	for (int i = 0; i < ht->dimHT; ++i)
	{
		NodLista* p = ht->vector[i];
		if (p)
		{
			printf("\nPe pozitia %d se afla elementele: ", i);
			while (p)
			{
				printf("\n  Id: %d Nume: %s", p->info.id, p->info.nume);
				p = p->next;
			}
		}
		else
		{
			printf("\nPe pozitia %d nu exista elemente;", i);
		}
	}
	printf("\n\n -------------------\n");
}

HashTable* CitireHashChaining(char* fileName, int dimHT) {
	HashTable* ht = initializareHashChaining(dimHT);
	NodLista* nod = NULL;
	User info;
	char buffer[255];

	FILE* fin = fopen(fileName, "r");
	if (fin)
	{
		while (!feof(fin))
		{
			fscanf(fin, "%d", &info.id);
			fscanf(fin, "%s", buffer);
			info.nume = (char*)malloc(sizeof(char)*(strlen(buffer) + 1));
			strcpy(info.nume, buffer);

			nod = CreareNod(info);
			InserareNodHash(ht, nod);
		}
	}
	else
	{
		printf("\nFisierul nu a fost deschis");
	}

	fclose(fin);
	return ht;
}

User CautareNodDupaIDChaining(HashTable* ht, int cod) {
	int poz = functieHashChaining(ht, cod);
	NodLista* lista = ht->vector[poz];
	User user;
	user.id = 0;
	user.nume = NULL;
	if (lista)
	{
		while (lista)
		{
			if (lista->info.id == cod)
			{
				user.id = cod;
				user.nume = (char*)malloc(sizeof(char)*(strlen(lista->info.nume) + 1));
				strcpy(user.nume, lista->info.nume);

				return user;
			}
			else
			{
				lista = lista->next;
			}
		}
	}

	printf("\nNu exista element pe pozitia cautata");

	return user;
}

void StergereNodDupaIdChaining(HashTable*& ht, int cod) {
	int poz = functieHashChaining(ht, cod);
	NodLista* lista = ht->vector[poz];
	if (lista)
	{
		if (lista->info.id == cod)
		{
			NodLista* p = lista;
			lista = lista->next;
			free(p->info.nume);
			free(p);
		}
		else
		{
			NodLista* p = lista;
			while (p->next && p->next->info.id != cod)
			{
				p = p->next;
			}
			if (p->next != NULL && p->next->info.id == cod)
			{
				NodLista* temp = p->next;
				p->next = p->next->next;
				free(temp->info.nume);
				free(temp);
			}
		}
		ht->vector[poz] = lista;
		printf("\nNodul a fost sters cu succes");
	}
	else
	{
		printf("\nNu exista element pe pozitia cautata");
	}
}

//lista dubla inlantuita
struct NodListaDubla {
	NodListaDubla* prev;
	Document info;
	NodListaDubla* next;
};

struct LDI {
	NodListaDubla *priml;
	NodListaDubla *ultiml;
};


LDI *InitiereLista() {
	LDI *lista = (LDI*)malloc(sizeof(LDI));
	lista->priml = NULL;
	lista->ultiml = NULL;

	return lista;
}

NodListaDubla* CreareNod(Document info) {
	NodListaDubla* nod = (NodListaDubla*)malloc(sizeof(NodListaDubla));
	nod->info = info;
	nod->next = NULL;
	nod->prev = NULL;

	return nod;
}

void InserareNodPrim(LDI*& lista, NodListaDubla* nod) {
	if (lista->priml)
	{
		nod->next = lista->priml;
		lista->priml->prev = nod;
		lista->priml = nod;
	}
	else
	{
		lista->priml = lista->ultiml = nod;
	}
}

void InserareNodUltim(LDI*& lista, NodListaDubla* nod) {
	if (lista->ultiml)
	{
		nod->prev = lista->ultiml;
		lista->ultiml->next = nod;
		lista->ultiml = nod;

	}
	else
	{
		lista->priml = lista->ultiml = nod;
	}
}

void AfisareListaPrim(LDI* lista) {
	if (lista->priml)
	{
		NodListaDubla* p = lista->priml;
		while (p)
		{
			printf("\nId: %d Nr pagini: %d Nume: %s, Status: %d", p->info.id, p->info.nrPagini, p->info.numeDocument, p->info.status);
			p = p->next;
		}
	}
	else
	{
		printf("\nNu exista elemente in lista");
	}
	printf("\n\n--------------\n");
}

void AfisareListaUltim(LDI* lista) {
	if (lista->ultiml)
	{
		NodListaDubla* p = lista->ultiml;
		while (p)
		{
			printf("\nId: %d Nr pagini: %d Nume: %s, Status: %d", p->info.id, p->info.nrPagini, p->info.numeDocument, p->info.status);
			p = p->prev;
		}
	}
	else
	{
		printf("\nNu exista elemente in lista");
	}
	printf("\n\n------------------\n");
}

LDI* CitireLista(char* fileName) {
	FILE* fin = fopen(fileName, "r");
	LDI* lista = InitiereLista();
	NodListaDubla* nod;
	Document info;
	char buffer[255];
	if (fin)
	{
		while (!feof(fin))
		{
			fscanf(fin, "%d", &info.id);
			fscanf(fin, "%d", &info.nrPagini);
			fscanf(fin, "%s", buffer);
			info.numeDocument = (char*)malloc(sizeof(char)*(strlen(buffer) + 1));
			strcpy(info.numeDocument, buffer);
			int stare;
			fscanf(fin, "%d", &stare);
			
			if (stare == 0)
				info.status = ON;
			else if (stare == 1)
				info.status = OFF;
			else info.status = INPROCES;

			nod = CreareNod(info);
			InserareNodUltim(lista, nod);
		}
		printf("\nLista a fost citita cu succes");
	}
	else
	{
		printf("\nFisierul nu s-a deschis");
	}
	fclose(fin);

	return lista;
}

void SteregereNodListaPrim(LDI*& lista) {
	if (lista->priml)
	{
		NodListaDubla* p = lista->priml;
		lista->priml = lista->priml->next;
		lista->priml->prev = NULL;
		free(p->info.numeDocument);
		free(p);
	}
	else
	{
		printf("\nNu exista elemente in lista");
	}
}

void SteregereNodListaUltim(LDI*& lista) {
	if (lista->priml)
	{
		NodListaDubla* p = lista->ultiml;
		lista->ultiml = lista->ultiml->prev;
		lista->ultiml->next = NULL;
		free(p->info.numeDocument);
		free(p);
	}
	else
	{
		printf("\nNu exista elemente in lista");
	}
}

void SteregereNodDupaID(LDI*& lista, int id) {
	if (lista->priml)
	{
		if (lista->priml->info.id == id)
		{
			NodListaDubla* p = lista->priml;
			lista->priml= lista->priml->next;
			lista->priml->prev = NULL;
			free(p->info.numeDocument);
			free(p);
		}
		else
		{
			NodListaDubla* p = lista->priml;
			while (p->next && p->next->info.id != id)
				p = p->next;
			if (p->next != nullptr && p->next->info.id == id)
			{
				NodListaDubla* temp = p->next;
				p->next = p->next->next;
				p->next->prev = p;

				free(temp->info.numeDocument);
				free(temp);
			}
			else
			{
				printf("\Nu exista elementul in lista");
			}
		}
	}
	else
	{
		printf("\nNu exista elemente in lista");
	}
}

void SteregereLista(LDI*& lista) {
	if (lista->priml)
	{
		while (lista->priml)
		{
			NodListaDubla* p = lista->priml;
			lista->priml = lista->priml->next;
			if (lista->priml)
				lista->priml->prev = NULL;
			else
				lista->ultiml = NULL;
			free(p->info.numeDocument);
			free(p);
		}
	}
	else
	{
		printf("\nNu exista elemente in lista");
	}
}

void main() {
	//coada
	printf("\n\n==========Coada=============");
	Coada* coada = CitesteCoada("Coada.txt");
	AfisareCoada(coada);

	User user = ExtragereNod(coada);
	printf("\n---%d %s", user.id, user.nume);
	AfisareCoada(coada);
	SteregereNod(coada);
	AfisareCoada(coada);

	/*printf("\n\n==========Hash Table-linear probing=============");

	HashTable ht = CitireHash("Coada.txt", 8);
	AfisareHash(ht);

	User user1 = CautaDupaID(ht, 1);
	printf("\nId: %d - Nume: %s", user1.id, user1.nume);

	StergereDupaID(ht, 3);
	AfisareHash(ht);

	stergereHash(ht);*/

	//Hash Table Chaining
	printf("\n\n==========Hash Table Chaining=============\n");
	HashTable* ht = CitireHashChaining("coada.txt", 4);
	AfisareHash(ht);
	//User user = CautareNodDupaIDChaining(ht, 4);
	//printf("\n-- %d %s", user.id, user.nume);

	StergereNodDupaIdChaining(ht, 15);
	AfisareHash(ht);
	StergereNodDupaIdChaining(ht, 1);
	AfisareHash(ht);

	printf("\n\n==========Lista dubla=============\n");
	printf("Status 0 = ON \nStatus 1 = OFF \nStatus 2 = INPROCESS\n");
	LDI* lista = CitireLista("Document.txt");
	AfisareListaPrim(lista);

	SteregereNodListaPrim(lista);
	SteregereNodListaUltim(lista);
	AfisareListaPrim(lista);

	
}