CREATE TABLE "ticket" (
    "ticket_id" SERIAL PRIMARY KEY,
	"cliente_id" INTEGER NOT NULL,
    "fecha_compra" DATE NOT NULL,
    "hora_compra" TIME NOT NULL,
    "monto_total" NUMERIC(10, 2) NOT NULL,
    "medio_pago" VARCHAR(50) NOT NULL,
    "productos" INTEGER NOT NULL,
    "observaciones" TEXT,
    "localidad" VARCHAR(100) NOT NULL,
    "descuento_aplicado" BOOLEAN DEFAULT FALSE
);