/*
 * Please do not edit this file.
 * It was generated using rpcgen.
 */

#include "hola.h"

bool_t
xdr_dobleString (XDR *xdrs, dobleString *objp)
{
	register int32_t *buf;

	 if (!xdr_string (xdrs, &objp->primero, 64))
		 return FALSE;
	 if (!xdr_string (xdrs, &objp->segundo, 2048))
		 return FALSE;
	return TRUE;
}