package com.adjemin.dix

import android.content.ContentResolver
import android.content.Context



class DixContactUtils {

    companion object{
        fun  getAllContacts(context: Context):List<Map<String, Any?>> {
            val cr: ContentResolver = context.getContentResolver();

            return FlutterContacts.get(cr, null, true, false, false, true)

        }

        fun  updateAllContacts(context: Context, list: List<Map<String, Any?>>) : List<String?>{
            val cr: ContentResolver = context.getContentResolver();

             return FlutterContacts.updateAll(cr, list);

        }

        fun  saveAllContacts(context: Context, list: List<Map<String, Any?>>) : List<Map<String, Any?>?>{
            val cr: ContentResolver = context.getContentResolver();

            return FlutterContacts.newAll(cr, list);

        }
    }


    /*private fun  getAllContacts(context: Context): List<DixContact> {

        val list = arrayListOf<DixContact>();

        val nameList: ArrayList<String> = ArrayList();
        val cr: ContentResolver = context.getContentResolver()

        val cur: Cursor? = cr.query(ContactsContract.Contacts.CONTENT_URI,
                null, null, null, null)


        if(cur != null && cur.count >0 ){

            while (cur.moveToNext()) {
                val id = cur.getString(
                        cur.getColumnIndex(ContactsContract.Contacts._ID));
                val name = cur.getString(cur.getColumnIndex(
                        ContactsContract.Contacts.DISPLAY_NAME));
                nameList.add(name);
                if (cur.getInt(cur.getColumnIndex( ContactsContract.Contacts.HAS_PHONE_NUMBER)) > 0) {
                    val  pCur:Cursor? = cr.query(ContactsContract.CommonDataKinds.Phone.CONTENT_URI,
                    null,
                    ContactsContract.CommonDataKinds.Phone.CONTACT_ID + " = ?",
                    arrayOf(id), null)

                    arrayListOf<String>()

                    if(pCur != null){
                        while (pCur.moveToNext()) {
                            val phoneNo = pCur.getString(pCur.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER));
                        }
                        pCur.close()
                    }
                }
            }
        }


        cur?.close()


        return list;
    }*/
}