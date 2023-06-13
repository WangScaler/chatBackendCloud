package com.wangscaler.chatcore.util;


import cn.hutool.core.util.CharsetUtil;
import cn.hutool.crypto.Mode;
import cn.hutool.crypto.Padding;
import cn.hutool.crypto.SecureUtil;
import cn.hutool.crypto.symmetric.AES;
import cn.hutool.crypto.symmetric.SymmetricAlgorithm;
import cn.hutool.crypto.symmetric.SymmetricCrypto;
import com.wangscaler.chatcore.constant.EncryptConstant;

/**
 * AES加密工具类
 *
 * @author wangscaler
 */
public class AESEncryptUtils {
    private static AES aes = new AES("CBC", "PKCS7Padding", EncryptConstant.AES_KEY.getBytes(), EncryptConstant.AES_IV.getBytes());
    /**
     * 加密
     *
     * @param value 要加密的字符串
     * @return 加密之后的字符串
     */
    public static String encrypt(String value) {
        //加密为16进制表示
        String encryptHex = aes.encryptHex(value);
        //返回
        return encryptHex;
    }

    /**
     * 解密
     *
     * @param value 要解密的字符串
     * @return 解密之后的字符串
     */
    public static String decrypt(String value) {
        try {
            //解密为字符串
            String encryptHex = aes.decryptStr(value);
            return encryptHex;
        } catch (Exception e) {

            return null;
        }
    }
}
