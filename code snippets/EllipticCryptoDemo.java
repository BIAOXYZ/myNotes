package com.asgard.crypto;

import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.SecureRandom;
import java.security.Security;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;

import org.bouncycastle.jcajce.provider.asymmetric.ec.IESCipher;
import org.bouncycastle.jce.ECNamedCurveTable;
import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.bouncycastle.jce.spec.ECNamedCurveParameterSpec;
import org.bouncycastle.util.encoders.Hex;

public class EllipticCryptoDemo {

	public static void main(String[] args) {
		// 生成公司密钥对
		KeyPair key = generateKeyPair();
		// 明文未加密内容
		String content = "unencrypted content";
		// 对内容加密
		byte[] encryptedContent = encrypt(content.getBytes(), key.getPublic());
		String encryptContentStr = Hex.toHexString(encryptedContent);
		System.out.println("encrypted content:" + encryptContentStr);
		// 对加密后的内容进行解密
		byte[] decryptedContent = decrypt(Hex.decode(encryptContentStr), key.getPrivate());
		String decryptedContentStr = new String(decryptedContent);
		System.out.println("decrypted content:" + decryptedContentStr);
	}

	/**
	 * 生成公私密钥对
	 * @return
	 */
	public static KeyPair generateKeyPair() {
		BouncyCastleProvider bc = new BouncyCastleProvider();
		Security.removeProvider(bc.getName());
		Security.addProvider(bc);
		ECNamedCurveParameterSpec ecGenSpec = ECNamedCurveTable.getParameterSpec("prime256v1");
		KeyPairGenerator g = null;
		try {
			g = KeyPairGenerator.getInstance("ECDSA", "BC");
		} catch (NoSuchAlgorithmException | NoSuchProviderException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			g.initialize(ecGenSpec, new SecureRandom());
		} catch (InvalidAlgorithmParameterException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return g.generateKeyPair();
	}

	/**
	 * 用ECC公钥加密数据。
	 *
	 * @param data
	 *            数据
	 * @param publicKey
	 *            公钥
	 * @return 加密后的数据
	 */
	public static byte[] encrypt(byte[] data, PublicKey publicKey) {
		try {
			IESCipher.ECIES c1 = new IESCipher.ECIES();
			c1.engineInit(Cipher.ENCRYPT_MODE, publicKey, new SecureRandom());
			return c1.engineDoFinal(data, 0, data.length);
		} catch (InvalidKeyException e) {
			throw new RuntimeException(e);
		} catch (BadPaddingException e) {
			throw new RuntimeException(e);
		} catch (IllegalBlockSizeException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 用ECC私钥解密数据。
	 *
	 * @param encryptedData
	 *            加密后的数据
	 * @param privateKey
	 *            私钥
	 * @return 解密后的数据
	 */
	public static byte[] decrypt(byte[] encryptedData, PrivateKey privateKey) {
		try {
			IESCipher.ECIES c1 = new IESCipher.ECIES();
			c1.engineInit(Cipher.DECRYPT_MODE, privateKey, new SecureRandom());
			return c1.engineDoFinal(encryptedData, 0, encryptedData.length);
		} catch (InvalidKeyException e) {
			throw new RuntimeException(e);
		} catch (BadPaddingException e) {
			throw new RuntimeException(e);
		} catch (IllegalBlockSizeException e) {
			throw new RuntimeException(e);
		}
	}
}
